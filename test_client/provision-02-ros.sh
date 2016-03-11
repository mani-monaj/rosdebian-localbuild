#/bin/bash

#rosdep update

mkdir ~/ros
cd ~/ros

wget "https://raw.githubusercontent.com/mani-monaj/rosdebian-localbuild/master/test_client/jade-debian-desktop-full-missing-packages_20160216.rosinstall" -O ws.rosinstall
wstool init -j8 src ws.rosinstall
catkin_make_isolated --install

test -e ~/ros/install_isolated/setup.bash
source ~/ros/install_isolated/setup.bash
