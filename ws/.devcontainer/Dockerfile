# NOTE: "jazzy" (ROS 2 Rolling) is not compatible with 
# https://github.com/UniversalRobots/Universal_Robots_ROS2_Gazebo_Simulation

# Base ROS image
ARG ROS_DISTRO=humble
FROM ros:${ROS_DISTRO}

# User configuration
ARG USERNAME=admin
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/bash
ENV ROS_DISTRO=${ROS_DISTRO}
ENV ROS_DOMAIN_ID=0

# Install system and ROS packages, create a user with sudo privileges
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        sudo \
        git \
        python3-pip \
        python3-vcstool \
        python3-rosdep \
        python3-colcon-common-extensions \
        gazebo \
        ros-${ROS_DISTRO}-rviz2 \
        ros-${ROS_DISTRO}-gazebo-ros-pkgs \
        ros-${ROS_DISTRO}-gazebo-ros2-control \
        ros-${ROS_DISTRO}-joint-state-publisher-gui \
        ros-${ROS_DISTRO}-ros2-control \
        ros-${ROS_DISTRO}-ros2-controllers \
        ros-${ROS_DISTRO}-joint-state-broadcaster \
        ros-${ROS_DISTRO}-ur \
        ros-${ROS_DISTRO}-ur-robot-driver \
        ros-${ROS_DISTRO}-ur-description \
        # standard networks commands for dev-container (ping, ip, net-tools)
        iputils-ping \
        iproute2 \
        net-tools \
    # Create group and user with sudo access
    && groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
    && echo "${USERNAME} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME} \
    # Clean up apt cache to reduce image size
    && rm -rf /var/lib/apt/lists/*

# Automatically source ROS setup in all shells
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /etc/bash.bashrc \
    && echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /home/${USERNAME}/.bashrc

# Switch to non-root user
USER ${USERNAME}



#-------------------- ROS2 UR GAZEBO SIMULATION WORKSPACE SETUP --------------------
# 1. Create workspace and clone repositories
RUN mkdir -p ~/workspaces/ur_gazebo/src \
    && cd ~/workspaces/ur_gazebo/src \
    && git clone -b humble https://github.com/UniversalRobots/Universal_Robots_ROS2_Gazebo_Simulation.git

# 2. Install system dependencies via rosdep
RUN /bin/bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash \
    && cd ~/workspaces/ur_gazebo \
    && sudo apt-get update \
    && rosdep update \
    && rosdep install --from-paths src --ignore-src -r -y \
    && sudo rm -rf /var/lib/apt/lists/*"

# 3. Build the workspace
RUN /bin/bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash \
    && cd ~/workspaces/ur_gazebo \
    && colcon build --symlink-install"

# 4. Source workspace in .bashrc
RUN echo "source ~/workspaces/ur_gazebo/install/setup.bash" >> ~/.bashrc



#------------------ Load external setup script for UR Gazebo workspace (cached by Docker) ---------------------
# Copy workspace setup script (requires root)
ARG ADDITIONAL_SETUP_SCRIPT=setup_workspace_additional.sh
USER root
COPY ${ADDITIONAL_SETUP_SCRIPT} /tmp/${ADDITIONAL_SETUP_SCRIPT}
RUN chmod +x /tmp/${ADDITIONAL_SETUP_SCRIPT}

# Build and prepare UR workspace inside the image
USER ${USERNAME}
RUN /bin/bash /tmp/${ADDITIONAL_SETUP_SCRIPT}





# Default shell
CMD ["/bin/bash"]
