#!/bin/bash
# ROS 2 설치 경로
source /opt/ros/humble/setup.bash

# TurtleBot3 워크스페이스 빌드 경로
source ~/turtlebot3_ws/install/setup.bash

# 환경 변수
export TURTLEBOT3_MODEL=burger

# shell 1: Gazebo 시뮬레이터 실행
gnome-terminal -- bash -c "export TURTLEBOT3_MODEL=burger; ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py; exec bash"

sleep 5  # Gazebo가 충분히 로딩될 시간

# shell 2: Navigation2 실행
gnome-terminal -- bash -c "export TURTLEBOT3_MODEL=burger; ros2 launch turtlebot3_navigation2 navigation2.launch.py use_sim_time:=True map:=$HOME/map.yaml; exec bash"

sleep 5  # nav2 bringup 시간 확보

# shell 3: 자동 목표 이동 Python 스크립트 실행
gnome-terminal -- bash -c "source ~/turtlebot3_ws/install/setup.bash; python3 $HOME/single_goal_nav.py; exec bash"







