#/bin/bash

sudo sh -c 'echo "deb http://sir.upc.edu/debian-robotics jessie-robotics main" > /etc/apt/sources.list.d/debian-robotics.list'
sudo apt-key adv --keyserver pgp.rediris.es --recv-keys 63DE76AC0B6779BF || apt-key adv --keyserver pgp.mit.edu --recv-keys 63DE76AC0B6779BF
sudo apt-get update -q

sudo apt-get install -qy catkin python-catkin-pkg python-rosdep python-wstool wget build-essential
sudo apt-get install -qy ros-desktop-full-dev libros-filters-plugins-dev

#rosbag (bug)
sudo apt-get install -qy libbz2-dev
#stage (bug)
sudo apt-get install -qy libfltk1.1-dev

#sudo rosdep init

