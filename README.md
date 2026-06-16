# Universal Robots ROS2 Gazebo Simulation - Setup & Launch Guide

This guide provides a clean, repeatable workflow to set up a ROS2 Humble workspace for Universal Robots Gazebo simulation in a docker container.

## Setup
1. Start the .devcontainer
2. go to [./run_scripts/](./ws\run_scripts\README.md) and start the .sh-files to connect to the robot (see README.md in this folder)


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
