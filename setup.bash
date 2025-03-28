if [ "${ROS_VERSION}" = 1 ]; then

  # ROS 1
  if [ -f "${HOME}/catkin_ws/devel_isolated/setup.bash" ]; then
    source ${HOME}/catkin_ws/devel_isolated/setup.bash

  elif [ -f "${HOME}/catkin_ws/devel/setup.bash" ]; then
    source ${HOME}/catkin_ws/devel/setup.bash

  elif [ -f "/workspace/catkin_ws/devel_isolated/setup.bash" ]; then
    source /workspace/catkin_ws/devel_isolated/setup.bash

  elif [ -f "/workspace/catkin_ws/devel/setup.bash" ]; then
    source /workspace/catkin_ws/devel/setup.bash

  elif [ -f "/opt/ros/${ROS_DISTRO}/setup.bash" ]; then
    source /opt/ros/${ROS_DISTRO}/setup.bash

  fi

else

  # ROS 2
  if [ -f "${HOME}/ros2_ws/install/setup.bash" ]; then
    source ${HOME}/ros2_ws/install/setup.bash

  elif [ -f "/workspace/ros2_ws/install/setup.bash" ]; then
    source /workspace/ros2_ws/install/setup.bash

  elif [ -f "/opt/ros/${ROS_DISTRO}/setup.bash" ]; then
    source /opt/ros/${ROS_DISTRO}/setup.bash

  fi

fi
