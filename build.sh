#!/bin/bash

set -e

ROOT=`pwd`
DB="$ROOT/db/ros-debian-science-pkg-list-sorted.txt"
SRC="$ROOT/src"

mkdir -p src
mkdir -p log

while IFS='' read -r line || [[ -n "$line" ]]; do
    pkg="$line"
    echo "[$pkg]"
    BUILD_DIR="$SRC/$pkg"
    mkdir -p $BUILD_DIR
    cd $BUILD_DIR

    LOG="$ROOT/log/$pkg.log"
    rm -f $LOG
    echo $pkg > $LOG

    echo "  LOG      : $LOG"
    echo "  BUILD_DIR: $BUILD_DIR"
    echo "  Deps ..."
    sudo apt-get --yes build-dep $pkg >> $LOG 2>&1
    
    echo "  Build ..."
    sudo apt-get --yes --build source $pkg >> $LOG 2>&1
   
    apt_pkgs=`cat *.dsc | grep Binary | cut -d ":" -f2 | sed -e 's/,//g'`

    echo " Installing $apt_pkgs ..."
    aptly repo add -force-replace=true rosdeb-release *.deb >> $LOG 2>&1
    aptly publish -force-overwrite=true -passphrase='*****' update jessie >> $LOG 2>&1
    sudo apt-get update -qq  >> $LOG 2>&1
    sudo apt-get install -yq $apt_pkgs  >> $LOG 2>&1
    cd $ROOT
done < $DB
