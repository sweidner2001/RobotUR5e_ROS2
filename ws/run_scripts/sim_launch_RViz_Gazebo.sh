#!/bin/bash
# ~/ws/run_scripts/launch_sim_RViz_Gazebo.sh
# Startet die UR5e-Simulation: Gazebo + MoveIt + RViz

# 1. ROS laden
source /opt/ros/humble/setup.bash

# 2. Workspace sourcen (prüfen ob gebaut)
COLCON_SETUP=~/workspaces/ur_gazebo/install/setup.bash
if [ -f "$COLCON_SETUP" ]; then
    source "$COLCON_SETUP"
else
    echo "FEHLER: Workspace nicht gebaut. Bitte zuerst 'colcon build' in ~/workspaces/ur_gazebo ausführen."
    exit 1
fi

# 3. Simulation starten (Gazebo + MoveIt + RViz in einem Befehl)
ros2 launch ur_simulation_gazebo ur_sim_control.launch.py