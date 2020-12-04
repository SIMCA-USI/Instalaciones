#!/bin/bash
# Se recogen las contraseñas necesarias
read -s -p "Enter sudo password : " sudopass
echo ""
read -p "Enter your Github user : " user
read -s -p "Enter your Github pass : " pass
echo ""
export CHOOSE_ROS_DISTRO=eloquent
# Se accede con sudo y se actualizan los repositorios
echo $sudopass | sudo -S apt update
sudo apt upgrade -y
# Se instalan librerías basicas que necesitaremos  mas adelante
sudo apt install curl gnupg2 lsb-release python3-argcomplete git python3-pip python-rosdep libpython3-dev -y
# Se inicializa y actualiza rosdep para dependencias de paquetes de ros
sudo rosdep init
rosdep update
# Se descarga eloquent y se instala junto con rqt y el compilador colcon
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
sudo apt update
sudo apt install ros-$CHOOSE_ROS_DISTRO-desktop ros-$CHOOSE_ROS_DISTRO-rqt-* python3-colcon-common-extensions -y
# Una vez instalado eloquent se instala rosbag
sudo apt install ros-$CHOOSE_ROS_DISTRO-ros2bag* ros-$CHOOSE_ROS_DISTRO-rosbag2-transport -y
# Se añade eloquent al bash y se identifica el ordenador con un id
source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash
echo "source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash" >> ~/.bashrc
echo "export ROS_DOMAIN_ID=2" >> ~/.bashrc
# Se crea el workspace
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
echo "export ROS_WS=~/ros2_ws" >> ~/.bashrc
# Se instalan algunos programas utiles
sudo snap install gitkraken
sudo snap install pycharm-community --classic
#dhcp 
sudo snap install sublime-text --classic
# Se instala la libreria bezier porque da problemas en la instalación como dependencia
export BEZIER_NO_EXTENSION=true
pip3 install bezier
# Se descargan los repositorios necesarios y se instalan las dependencias
git clone https://$user:$pass@github.com/SIMCA-USI/ros2_waypoints.git && echo "Cloned"
git clone https://$user:$pass@github.com/SIMCA-USI/ros2_gps.git && echo "Cloned"
git clone https://$user:$pass@github.com/SIMCA-USI/ros_can.git && echo "Cloned"
git clone https://$user:$pass@github.com/SIMCA-USI/ros2_keyboard.git && echo "Cloned"
# Se recorren todos los directorios de la carpeta source y se instalan las dependencias de python
for D in *; do
	if [ -d "${D}" ]; then
		cd "${D}"
		pip3 install .
		cd ..
	fi
done
# Se instalan las dependencias de paquetes de ros
cd ~/ros2_ws
sudo rosdep install -i --from-path src --rosdistro $CHOOSE_ROS_DISTRO -y
# Se complilan los paquetes
colcon build --symlink-install
# Se instalan los paquetes para poder ser utilizados
. install/setup.bash
source ~/ros2_ws/install/setup.bash
echo "source ~/ros2_ws/install/setup.bash" >> ~/.bashrc
echo "alias build='cd $ROS_WS && colcon build --symlink-install && . install/setup.bash ; cd -'" >> ~/.bashrc
echo "alias dhcp='sudo dnsmasq -C /dev/null -kd -F 192.168.0.10,192.168.0.20 -i enp1s0 --bind-dynamic'" >> ~/.bashrc