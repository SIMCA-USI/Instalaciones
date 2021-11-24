#!/bin/bash
# Se recogen las contraseñas necesarias
read -s -p "Enter sudo password : " sudopass
echo ""
# Se accede con sudo y se actualizan los repositorios
echo $sudopass | sudo -S apt update && sudo apt install curl gnupg2 lsb-release -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update
# Se instala ros y colcon
sudo apt install ros-foxy-desktop python3-colcon-common-extensions -y
# Preparación del entorno
echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
echo "source ~/ros2_ws/install/setup.bash" >> ~/.bashrc
echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
echo "export _colcon_cd_root=~/ros2_install" >> ~/.bashrc
echo "export ROS_DOMAIN_ID=2" >> ~/.bashrc
mkdir -p ~/ros2_ws/src
echo "export ROS_WS=~/ros2_ws" >> ~/.bashrc
# Alias por facilidad
echo "alias build='cd ~/ros2_ws && colcon build --symlink-install && . install/setup.bash ; cd -'" >> ~/.bashrc
# Instalación de herramientas
sudo snap install gitkraken --classic
sudo snap install pycharm-community --classic
sudo snap install sublime-text --classic