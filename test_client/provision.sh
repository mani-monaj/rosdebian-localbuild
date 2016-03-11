#/bin/bash

sudo sh -c 'echo "deb http://sir.upc.edu/debian-robotics jessie-robotics main" > /etc/apt/sources.list.d/debian-robotics.list'
sudo apt-key adv --keyserver pgp.rediris.es --recv-keys 63DE76AC0B6779BF || apt-key adv --keyserver pgp.mit.edu --recv-keys 63DE76AC0B6779BF
sudo apt-get update -q

sudo apt-get install -qy catkin python-catkin-pkg python-rosdep python-wstool wget
sudo apt-get install -qy ros-desktop-full-dev libros-filters-plugins-dev

#sudo rosdep init
#rosdep update

mkdir ~/ros
cd ~/ros

wget "https://raw.githubusercontent.com/mani-monaj/rosdebian-localbuild/master/test_client/jade-debian-desktop-full-missing-packages_20160216.rosinstall" -O ws.rosinstall
wstool init -j8 src ws.rosinstall
catkin_make_isolated --install

test -e ~/ros/install_isolated/setup.bash
source ~/ros/install_isolated/setup.bash
