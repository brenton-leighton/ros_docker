if [ "${ROS_VERSION}" = 1 ]; then

  # ROS 1
  if [ -f "${HOME}/catkin_ws/devel_isolated/setup.sh" ]; then
    . ${HOME}/catkin_ws/devel_isolated/setup.sh

  elif [ -f "${HOME}/catkin_ws/devel/setup.sh" ]; then
    . ${HOME}/catkin_ws/devel/setup.sh

  elif [ -f "/workspace/catkin_ws/devel_isolated/setup.sh" ]; then
    . /workspace/catkin_ws/devel_isolated/setup.sh

  elif [ -f "/workspace/catkin_ws/devel/setup.sh" ]; then
    . /workspace/catkin_ws/devel/setup.sh

  elif [ -f "/opt/ros/${ROS_DISTRO}/setup.sh" ]; then
    . /opt/ros/${ROS_DISTRO}/setup.sh

  fi

else

  # ROS 2
  if [ -f "${HOME}/ros2_ws/install/setup.sh" ]; then
    . ${HOME}/ros2_ws/install/setup.sh

  elif [ -f "/workspace/ros2_ws/install/setup.sh" ]; then
    . /workspace/ros2_ws/install/setup.sh

  elif [ -f "/opt/ros/${ROS_DISTRO}/setup.sh" ]; then
    . /opt/ros/${ROS_DISTRO}/setup.sh

  fi

fi
