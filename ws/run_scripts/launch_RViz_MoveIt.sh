#!/bin/bash
# ~/ws/run_scripts/run.sh

# Basis-Verzeichnis (Root) finden
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Root-Verzeichnis: $ROOT_DIR"

source /opt/ros/humble/setup.bash
source ~/workspaces/ur_gazebo/install/setup.bash

# 2. Prüfen, ob der Workspace schon gebaut wurde
# if [ -f "$WORKSPACE_DIR/install/setup.bash" ]; then
#     source "$WORKSPACE_DIR/install/setup.bash"
# else
#     echo "FEHLER: Workspace nicht gefunden. Hast du colcon build schon ausgeführt?"
#     exit 1
# fi

# Startet das Launch-File (achte darauf, dass es im Paket-Pfad ist)
ros2 launch "$ROOT_DIR/run_scripts/launch_RViz_MoveIt.py"