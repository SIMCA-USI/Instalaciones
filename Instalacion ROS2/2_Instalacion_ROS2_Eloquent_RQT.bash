#/bin/bash
sudo apt update
sudo apt install ros-eloquent-desktop
source /opt/ros/eloquent/setup.bash
sudo apt install python3-argcomplete
echo "source /opt/ros/<distro>/setup.bash" >> ~/.bashrc
sudo apt update
sudo apt install ros-eloquent-rqt-*