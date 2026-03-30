# Universal Robots ROS2 Gazebo Simulation - Setup & Launch Guide

This guide provides a clean, repeatable workflow to set up a ROS2 Humble workspace for Universal Robots Gazebo simulation in a docker container.

## Workspace Setup

```bash
# Define workspace
COLCON_WS=~/workspaces/ur_gazebo
mkdir -p $COLCON_WS/src
cd $COLCON_WS/src

# Clone required repositories (Humble branch). Only clone if directory does not already exist to prevent errors
if [ ! -d "Universal_Robots_ROS2_Gazebo_Simulation" ]; then
    git clone -b humble https://github.com/UniversalRobots/Universal_Robots_ROS2_Gazebo_Simulation.git
fi

if [ ! -d "Universal_Robots_ROS2_Driver" ]; then
    git clone -b humble https://github.com/UniversalRobots/Universal_Robots_ROS2_Driver.git
fi

# Install ROS 2 Control and required system dependencies
sudo apt update
sudo apt upgrade -y
sudo apt install -y \
    ros-humble-ros2-control \
    ros-humble-ros2-controllers \
    ros-humble-joint-state-broadcaster

# Install ROS dependencies for all cloned packages
cd $COLCON_WS
rosdep update
rosdep install --from-paths src --ignore-src -r -y

# Build workspace
colcon build --symlink-install

# Source workspace for this shell
source install/setup.bash

# Add workspace source to .bashrc for future shells
grep -qxF "source $COLCON_WS/install/setup.bash" ~/.bashrc || \
    echo "source $COLCON_WS/install/setup.bash" >> ~/.bashrc
```

## Running Simulation

1. Run simulation: 
```bash
ros2 launch ur_simulation_gazebo ur_sim_control.launch.py
```

2. Move robot using test script from ur_robot_driver package (if you've installed that one):
```bash
ros2 launch ur_robot_driver test_joint_trajectory_controller.launch.py
```

3. Example using MoveIt with simulated robot:
```bash
ros2 launch ur_simulation_gazebo ur_sim_moveit.launch.py
```
