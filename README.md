# Intro

- My local setup to build 32bit [ROS Debian packages](https://wiki.debian.org/DebianScience/Robotics/ROS/Packages) from source using source debs, [Vagrant](https://www.vagrantup.com/) and [aptly](http://www.aptly.info/).
- i386 build is now enabled on ROS Debian build servers, so this repo mainly serves as a personal reference.

# Vagrant Setup

Host: Ubuntu 14.04.3 64bit, Vagrant 1.8.3
Build Box: Debian Jessie 32bit
Vagrantfile: In the repo

```bash
$ vagrant box add box-cutter/debian81-i386 # with virtualbox backend
$ vagrant init box-cutter/debian81-i386
```

## Box Setup

(`vagrant ssh`)

```bash
$ dpkg-reconfigure tzdata
$ dpkg-reconfigure locales
$ sudo apt-get upgrade
$ sudo apt-get install build-essential fakeroot devscripts dpkg-dev vim tmux htop rng-tools aptly
$ sudo sh -c 'echo "deb http://sir.upc.edu/debian-robotics jessie-robotics main" > /etc/apt/sources.list.d/debian-robotics.list'
$ sudo apt-key adv --keyserver pgp.rediris.es --recv-keys 63DE76AC0B6779BF
```

### `aptly` setup

```bash
$ aptly repo create -distribution=jessie -component=main -architectures=i386 rosdeb-release
$ gpg --gen-key
$ gpg --export --armor [EMAIL] > pubkey.asc
$ sudo sh -c 'deb http://localhost:8080/ jessie main" >> /etc/apt/sources.list.d/debian-robotics.list'
```

Some useful `aptly` commands

```bash
$ aptly publish -architectures="i386" repo rosdeb-release
$ aptly repo show -with-packages rosdeb-release
$ aptly repo add rosdeb-release *.deb
$ aptly publish -passphrase='*****' update jessie
```

### Setup a private key repository

Ref: https://njh.eu/keyserver

# Run the build

1. Update `db/ros-debian-science-pkg-list-sorted.txt` if necessary in order of dependency 
2. Make sure `aptly` is serving the local repo `aptly serve`
3. Run `build.sh`

# Setup the client i386 machine (Debian Jessie)

- The host forwards http and keyserver request to the VM

```bash
$ sudo sh -c 'deb http://host:8080/ jessie main" >> /etc/apt/sources.list.d/debian-robotics.list'
$ sudo apt-key adv --keyserver host --recv-keys <generated key fingerprint>
```

## Test

```bash
$ sudo apt-get install catkin python-catkin-pkg python-rosdepros
$ sudo apt-get install ros-core ros-base-dev # ~300Mb
$ sudo rosdep init
$ rosdep update
```

# References

- https://wiki.debian.org/BuildingTutorial
- https://beingasysadmin.wordpress.com/2014/12/07/automating-debian-package-management/
- https://jodal.no/2015/03/08/building-arm-debs-with-pbuilder/