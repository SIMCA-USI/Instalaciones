#/bin/bash
sudo apt update
sudo apt install curl gnupg2 lsb-release python3-argcomplete
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
sudo apt update
sudo apt install ros-eloquent-desktop ros-eloquent-rqt-*
source /opt/ros/eloquent/setup.bash
echo "source /opt/ros/eloquent/setup.bash" >> ~/.bashrc
echo "export ROS_DOMAIN_ID=2" >> ~/.bashrc
mkdir -p ~/ros2_ws/src