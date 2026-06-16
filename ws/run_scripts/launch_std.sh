#!/bin/bash
# ~/ws/run_scripts/run.sh

# Basis-Verzeichnis (Root) finden
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Root-Verzeichnis: $ROOT_DIR"

source /opt/ros/humble/setup.bash

# Startet das Launch-File (achte darauf, dass es im Paket-Pfad ist)
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}" .sh).py"
ros2 launch "$ROOT_DIR/run_scripts/run_scripts_python/$SCRIPT_NAME"