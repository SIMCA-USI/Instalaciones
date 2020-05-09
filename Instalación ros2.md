# Instalación ROS2
## Sistema operativo
    Ubuntu 18.04
## Instalar en un USB Booteable usando la aplicación
[Unetbooting](https://unetbootin.github.io)

## Instalación
### Add ROS2 apt repository
```sh
sudo apt update && sudo apt install curl gnupg2 lsb-release
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
```

### Instalación Eloquent
```sh
sudo apt update
sudo apt install ros-eloquent-desktop
source /opt/ros/eloquent/setup.bash
echo "source /opt/ros/eloquent/setup.bash" >> ~/.bashrc
sudo apt install python3-argcomplete
```

### Creación del repositorio
```sh
echo "export ROS_DOMAIN_ID=<your_domain_id>" >> ~/.bashrc
mkdir -p ~/ros2_ws/src
```

### RQT
```sh
sudo apt update
sudo apt install ros-<distro>-rqt-*
```

### Compilación
```sh
sudo apt install python3-colcon-common-extensions

colcon build --symlink-install
. install/setup.bash
```

### Dependences of packages
```sh
sudo rosdep install -i --from-path src --rosdistro <distro> -y
```
## Documentación
[ROS2](https://index.ros.org/doc/ros2/)