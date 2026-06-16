#!/bin/bash
set -e


# 1. Variablen definieren und Verzeichnisse sicherstellen
COLCON_WS=~/workspaces/robotiq_gripper
mkdir -p $COLCON_WS/src
cd $COLCON_WS

# 2. ROS-Umgebung laden
source /opt/ros/humble/setup.bash

# 3. Paketindex aktualisieren fuer rosdep/apt
sudo apt update

# 4. Repositories klonen (falls nicht vorhanden)
cd $COLCON_WS/src
# serial wird von robotiq_driver benötigt (ROS2-kompatibler Fork)
if [ ! -d "serial" ]; then
    git clone -b ros2 https://github.com/tylerjw/serial.git
fi


# Robotiq Gripper
if [ ! -d "ros2_robotiq_gripper" ]; then
    git clone -b humble https://github.com/PickNikRobotics/ros2_robotiq_gripper.git
fi


# 5. VCS Import: Holt die exakt passenden Abhängigkeiten (ur_msgs, ur_client_library etc.)
cd $COLCON_WS
# vcs import src < src/Universal_Robots_ROS2_Driver/Universal_Robots_ROS2_Driver.humble.repos

# 6. System-Abhängigkeiten installieren
rosdep update
rosdep install --from-paths src --ignore-src -r -y

# 7. Sauberer Build
colcon build --symlink-install

# 8. Workspace sourcen
source install/setup.bash


# Add workspace source to .bashrc for future shells
grep -qxF "source $COLCON_WS/install/setup.bash" ~/.bashrc || \
    echo "source $COLCON_WS/install/setup.bash" >> ~/.bashrc