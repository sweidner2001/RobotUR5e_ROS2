# 1. Variablen definieren und Verzeichnisse sicherstellen
COLCON_WS=~/workspaces/ur_gazebo
mkdir -p $COLCON_WS/src
cd $COLCON_WS

# 2. Reste von 'Rolling' und alte Build-Artefakte entfernen
# sudo apt remove -y ros-rolling-* || true
# sudo apt autoremove -y
# rm -rf build/ install/ log/

# 3. Benötigte Tools installieren
sudo apt update
# sudo apt install -y python3-vcstool python3-rosdep python3-colcon-common-extensions

# 4. Repositories klonen (falls nicht vorhanden)
cd $COLCON_WS/src
if [ ! -d "Universal_Robots_ROS2_Driver" ]; then
    git clone -b humble https://github.com/UniversalRobots/Universal_Robots_ROS2_Driver.git
fi

if [ ! -d "Universal_Robots_ROS2_Gazebo_Simulation" ]; then
    git clone -b humble https://github.com/UniversalRobots/Universal_Robots_ROS2_Gazebo_Simulation.git
fi


# sudo apt update
# Explizite Installation der Core-Steuerung (als Backup zu rosdep)
#sudo apt install -y \
#    ros-humble-ros2-control \
#    ros-humble-ros2-controllers \
#    ros-humble-joint-state-broadcaster

# 5. VCS Import: Holt die exakt passenden Abhängigkeiten (ur_msgs, ur_client_library etc.)
cd $COLCON_WS
vcs import src < src/Universal_Robots_ROS2_Driver/Universal_Robots_ROS2_Driver.humble.repos

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