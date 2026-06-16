# Start Scripts

All scripts are launched from the `run_scripts` directory:

```bash
cd run_scripts
```

Configuration (robot IP, UR type, RViz launch) is managed via the `robot_config.yaml` file.

---

## Real Hardware

### Connect to Robot - without MoveIt

Launches the **UR robot driver** to connect to a real UR robot. Only the driver (`ur_control.launch.py`) is started – without MoveIt and without RViz (depending on `robot_config.yaml`).

```bash
bash launch_std.sh
```

### Connect to Robot - with MoveIt

Launches the **UR robot driver together with MoveIt and RViz**. This allows controlling the real robot via the MoveIt planning interface in RViz.

```bash
bash launch_RViz_MoveIt.sh
```

---

## Simulation (Gazebo)

> **Prerequisite:** The Gazebo workspace must be built beforehand (`colcon build` in `~/workspaces/ur_gazebo`).

### Connect to Sim - without MoveIt

Launches the **UR5e simulation in Gazebo with RViz** (`ur_sim_control.launch.py`). The robot is simulated and can be visualized via RViz.

```bash
bash sim_launch_RViz_Gazebo.sh
```

### Connect to Sim - with MoveIt

Launches the **UR5e simulation in Gazebo with MoveIt and RViz** (`ur_sim_moveit.launch.py`). In addition to the simulation, MoveIt is loaded, enabling motion planning within the simulation.

```bash
bash sim_launch_RViz_MoveIt_Gazebo.sh
```

---

## Overview

| Script | Environment | Driver | MoveIt | RViz | Gazebo |
|---|---|---|---|---|---|
| `launch_std.sh` | Real HW | Yes | No | Configurable | No |
| `launch_RViz_MoveIt.sh` | Real HW | Yes | Yes | Yes | No |
| `sim_launch_RViz_Gazebo.sh` | Simulation | Yes | No | Yes | Yes |
| `sim_launch_RViz_MoveIt_Gazebo.sh` | Simulation | Yes | Yes | Yes | Yes |