#!/bin/bash

# 터틀봇 모델 지정
export TURTLEBOT3_MODEL=burger

# shell 1: Gazebo 시뮬레이터 실행
gnome-terminal -- bash -c "source /opt/ros/humble/setup.bash; export TURTLEBOT3_MODEL=burger; ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py; exec bash"

sleep 5

# shell 2: Navigation2 실행
gnome-terminal -- bash -c "source /opt/ros/humble/setup.bash; export TURTLEBOT3_MODEL=burger; ros2 launch turtlebot3_navigation2 navigation2.launch.py use_sim_time:=True map:=$HOME/map.yaml; exec bash"

sleep 5

# shell 3: 자동 목표 이동 Python 스크립트 실행
gnome-terminal -- bash -c "source ~/turtlebot3_ws/install/setup.bash; python3 $HOME/single_goal_nav.py; exec bash"






