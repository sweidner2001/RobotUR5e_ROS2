# Dev Container Setup

## Overview

This dev container provides a fully configured **ROS 2 Humble** development environment for UR robot development, including Gazebo simulation, MoveIt, and RViz.

---

## Workflow

```
devcontainer.json
    └── builds Dockerfile
            └── runs setup_workspace_additional.sh  (baked into the image)
    └── after build: runs setup_workspace_temp.sh   (runs on every container creation)
```

1. **`devcontainer.json`** triggers the Docker image build using the `Dockerfile`.
2. **`Dockerfile`** sets up the full ROS 2 environment and at the end executes `setup_workspace_additional.sh`, which is a permanent part of the image build.
3. Once the image is built, **`devcontainer.json`** runs `setup_workspace_temp.sh` via `postCreateCommand`. This script runs every time the container is created, allowing experimental package installations or workspace setup steps without modifying the Dockerfile or rebuilding the image.

---

## Files

| File | Description |
|---|---|
| `devcontainer.json` | Dev container configuration (user, mounts, env vars, extensions, post-create command) |
| `Dockerfile` | Builds the ROS 2 Humble image with UR driver, Gazebo, RViz, and the UR Gazebo simulation workspace |
| `setup_workspace_additional.sh` | Permanent setup script, executed during the Docker image build |
| `setup_workspace_temp.sh` | Temporary setup script, executed after container creation — safe for experimental changes |

---

## What the Dockerfile installs

- ROS 2 Humble (base image)
- Gazebo + ROS 2 Gazebo packages
- RViz2
- `ros2_control` / `ros2_controllers`
- UR robot driver (`ros-humble-ur`, `ros-humble-ur-robot-driver`)
- Python tools: `pip`, `vcstool`, `rosdep`, `colcon`
- Network tools: `ping`, `ip`, `net-tools`
- Clones and builds the [Universal Robots ROS 2 Gazebo Simulation](https://github.com/UniversalRobots/Universal_Robots_ROS2_Gazebo_Simulation) workspace at `~/workspaces/ur_gazebo`

---

## Container Configuration

| Setting | Value |
|---|---|
| User | `admin` |
| Workspace mount | `${localWorkspaceFolder}` → `/home/ws` |
| ROS Domain ID | `0` |
| Network mode | `host` |
| Display (GUI) | Forwarded via `DISPLAY` and `/tmp/.X11-unix` |
| GPU | `/dev/dri` mounted for hardware acceleration |

---

## VS Code Extensions (auto-installed)

- C/C++ (`ms-vscode.cpptools`)
- CMake (`twxs.cmake`)
- Python Extension Pack
- GitLens
- GitHub Copilot Chat
- ROS (`ms-iot.vscode-ros`)
- RDE Pack (`Ranch-Hand-Robotics.rde-pack`) 