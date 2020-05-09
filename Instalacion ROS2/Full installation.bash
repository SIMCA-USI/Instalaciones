#!/bin/bash
# Se recogen las contraseñas necesarias
read -s -p "Enter sudo password : " sudopass
read -p "Enter your Github user : " user
read -s -p "Enter your Github pass : " pass
# Se accede con sudo y se actualizan los repositorios
echo $sudopass | sudo -S apt update
# Se instalan librerías basicas que necesitaremos  mas adelante
sudo apt install curl gnupg2 lsb-release python3-argcomplete git python3-pip python-rosdep libpython3-dev -y
# Se inicializa y actualiza rosdep para dependencias de paquetes de ros
sudo rosdep init
rosdep update
# Se descarga eloquen y se instala junto con rqt y el compilador colcon
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
sudo apt update
sudo apt install ros-eloquent-desktop ros-eloquent-rqt-* python3-colcon-common-extensions -y
# Se añade eloquent al bash y se identifica el ordenador con un id
source /opt/ros/eloquent/setup.bash
echo "source /opt/ros/eloquent/setup.bash" >> ~/.bashrc
echo "export ROS_DOMAIN_ID=2" >> ~/.bashrc
# Se crea el workspace
mkdir -p ~/ros2_ws/src
# Se instalan algunos programas utiles
sudo snap install gitkraken
sudo snap install pycharm-community --classic
# Se instala la libreria bezier porque da problemas en la instalación como dependencia
BEZIER_NO_EXTENSION=true
pip3 install bezier
# Se descargan los repositorios necesarios y se instalan las dependencias
git clone https://$user:$pass@github.com/SIMCA-USI/ros2_waypoints.git
cd ros2_waypoints && pip3 install . && cd ..
git clone https://$user:$pass@github.com/SIMCA-USI/ros2_gps.git
cd ros2_gps && pip3 install . && cd ..
git clone https://$user:$pass@github.com/SIMCA-USI/ros_can.git
cd ros_can && pip3 install . && cd ..
# Se instalan las dependencias de paquetes de ros
cd ~/ros2_ws
sudo rosdep install -i --from-path src --rosdistro $ROS_DISTRO -y
# Se complilan los paquetes
colcon build --symlink-install
# Se instalan los paquetes para poder ser utilizados
. install/setup.bash