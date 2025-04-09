# ros_docker

Files for ROS development in Docker.
Similar to [rocker](https://github.com/osrf/rocker), but simpler and does some additional things.

The containers:
- Run as the current user (the images are therefore not portable between users or computers)
- Mount a host folder for the home directory to allow for persistent bash history, configuration files, etc.
- Source ROS setup scripts from common locations (and for bash too)
- Set up colcon command completion (for ROS 2)

There are also containers for running GUI applications, NVIDIA TensorRT, or Avahi mDNS

## Basic usage

- Ensure a recent version of [Docker Engine](https://docs.docker.com/engine/install/) (or Docker Desktop) is installed and can be [run by you](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user)
- Run a script in the bin folder to start a shell in a container, e.g.
```bash
./ros_humble_base
```
- The scripts can also be used to run a command directly, e.g.
```bash
./ros_humble_base ros2 topic list
```
- The container image is built only on the first run, to build it again (i.e. if the Dockerfile has changed) use the `-b` option, e.g.
```bash
./ros_humble_base -b
```

## Environment variables

The compose files container a number of environment variables that will be set if they are set on the host:

- ROS 2:
  - `ROS_DOMAIN_ID`
  - `ROS_AUTOMATIC_DISCOVERY_RANGE` (jazzy and later)
  - `ROS_LOCALHOST_ONLY` (humble and earlier)
  - `ROS_STATIC_PEERS`
  - `RMW_IMPLEMENTATION`
  - `RCUTILS_CONSOLE_OUTPUT_FORMAT`
  - `RCUTILS_COLORIZED_OUTPUT`
  - `RCUTILS_LOGGING_USE_STDOUT`
  - `RCUTILS_LOGGING_BUFFERED_STREAM`
- ROS 1:
  - `ROS_MASTER_URI`
  - `ROS_HOSTNAME`
  - `ROS_IP`

## Making changes

### `Dockerfile`

Edit a container's [`Dockerfile`](https://docs.docker.com/reference/dockerfile/) to change how the image is built, e.g. to install additional packages

### `compose.yaml`

Edit a container's [`compose.yaml`](https://docs.docker.com/reference/compose-file/) file to change how the container is run, e.g.
- [Mount volumes](https://docs.docker.com/reference/compose-file/services/#volumes) (like a `ros2_ws`/`catkin_ws` folder)
- [Add devices](https://docs.docker.com/reference/compose-file/services/#devices)
- [Set environment variables](https://docs.docker.com/reference/compose-file/services/#environment)

## Tips

- Add the bin folder to your `PATH` environment variable to run the containers anywhere, e.g. by adding the following to `~/.bashrc`:

```bash
export PATH="${HOME}/path/to/ros_docker/bin:${PATH}"
```

- When building packages you can use `rosdep` to find dependencies:

```bash
# Run from the workspace directory
rosdep check -i --from-paths src/
```
