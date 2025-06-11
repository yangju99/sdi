#!/bin/bash

# gnome-terminal로 각각의 명령을 로그인 셸처럼 실행
gnome-terminal -- bash -c "source ~/.bashrc; ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py; exec bash"
sleep 5  # Gazebo가 충분히 로딩될 시간

gnome-terminal -- bash -c "source ~/.bashrc; ros2 launch turtlebot3_navigation2 navigation2.launch.py use_sim_time:=True map:=$HOME/map.yaml; exec bash"
sleep 5  # nav2 bringup 시간 확보

gnome-terminal -- bash -c "source ~/.bashrc; python3 \$HOME/single_goal_nav.py; exec bash"







