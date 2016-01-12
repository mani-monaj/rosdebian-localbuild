#/bin/bash

sudo sh -c 'echo "deb http://sir.upc.edu/debian-robotics jessie-robotics main" > /etc/apt/sources.list.d/debian-robotics.list'
sudo apt-key adv --keyserver pgp.rediris.es --recv-keys 63DE76AC0B6779BF
sudo apt-get update -q

sudo apt-get install -qy catkin python-catkin-pkg python-rosdep python-wstool wget
sudo apt-get install -qy ros-core ros-core-dev
sudo apt-get install -qy ros-core-rosbuild-dev
sudo apt-get install -qy ros-core-python-dev
sudo apt-get install -qy ros-base ros-base-dev
sudo apt-get install -qy ros-robot ros-robot-dev
sudo apt-get install -qy ros-perception ros-perception-dev
sudo apt-get install -qy ros-viz ros-viz-dev
sudo apt-get install -qy ros-simulators ros-simulators-dev
sudo apt-get install -qy ros-desktop-full-depends

sudo rosdep init
rosdep update

mkdir ~/ros
cd ~/ros
wget "https://wiki.debian.org/DebianScience/Robotics/ROS?action=AttachFile&do=get&target=jade-debian-desktop-full-missing-packages.rosinstall" -O jade-debian-desktop-full-missing-packages.rosinstall
wstool init -j8 src jade-debian-desktop-full-missing-packages.rosinstall
catkin_make_isolated --install
