# ROS related things

# Replace entrypoint script
RUN rm /ros_entrypoint.sh
COPY setup.sh /
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

# Bash setup for command completion
COPY setup.bash /
RUN bash -c "echo -e \\\nsource /setup.bash >> /etc/bash.bashrc"

# colcon command completion for ROS 2
RUN if [ "${ROS_DISTRO}" != "noetic" ]; then bash -c "echo -e source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash >> /etc/bash.bashrc"; fi
