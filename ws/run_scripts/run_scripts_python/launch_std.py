# ~/dein-projekt-root/run_scripts/master_launch.py
import os
import yaml
from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription, LogInfo
from launch.launch_description_sources import PythonLaunchDescriptionSource
from ament_index_python.packages import get_package_share_directory

def generate_launch_description():
    # 1. Config finden (liegt eine Ebene höher als dieses Script)
    script_dir = os.path.dirname(os.path.realpath(__file__))
    config_path = os.path.join(script_dir, '..', '..', 'robot_config.yaml')
    
    with open(config_path, 'r') as f:
        config = yaml.safe_load(f)['robot_params']['ros__parameters']

    # 2. Launch Files der UR-Pakete finden
    # Diese Pakete liegen im 'install'-Ordner des Workspaces
    driver_launch_file = os.path.join(
        get_package_share_directory('ur_robot_driver'), 
        'launch', 'ur_control.launch.py')


    # 3. Den UR-Treiber inkludieren
    driver_launch = IncludeLaunchDescription(
        PythonLaunchDescriptionSource([driver_launch_file]),
        launch_arguments={
            'ur_type': config['ur_type'],
            'robot_ip': config['robot_ip'],
            'launch_rviz': str(config['launch_rviz']).lower()
        }.items()
    )


    return LaunchDescription([
        LogInfo(msg=f"Starte System für {config['ur_type']}..."),
        driver_launch,
    ])