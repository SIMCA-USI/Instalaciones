# Instalación ROS2 Foxy
## Sistema operativo
[Ubuntu 20.04](https://ubuntu.com/download/desktop)
## Instalar en un USB Booteable usando la aplicación
[Unetbooting](https://unetbootin.github.io)

## Instalación
### Add ROS2 apt repository
```sh
sudo -S apt update && sudo apt install curl gnupg2 lsb-release -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
```

### Instalación Foxy
```sh
sudo apt update
sudo apt install ros-foxy-desktop python3-colcon-common-extensions -y
```

### Configuración del entorno
```sh
echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
echo "source ~/ros2_ws/install/setup.bash" >> ~/.bashrc
echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
echo "export _colcon_cd_root=~/ros2_install" >> ~/.bashrc
```

### Creación del WorkSpace
```sh
echo "export ROS_DOMAIN_ID=<your_domain_id>" >> ~/.bashrc
mkdir -p ~/ros2_ws/src
echo "export ROS_WS=~/ros2_ws" >> ~/.bashrc
```

### Extra
```sh
echo "alias build='cd ~/ros2_ws && colcon build --symlink-install && . install/setup.bash ; cd -'" >> ~/.bashrc
echo "alias dhcp='sudo dnsmasq -C /dev/null -kd -F 192.168.0.10,192.168.0.20 -i enp1s0 --bind-dynamic'" >> ~/.bashrc
```

## Documentación
[ROS2](https://index.ros.org/doc/ros2/)