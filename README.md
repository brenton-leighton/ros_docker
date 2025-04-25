# ros_docker

Containers for working with ROS in Docker.

All the containers:

- Run as the current user
- Set environment variables from the host
- Mount a host folder for the home directory to allow for persistent bash history, configuration files, etc.
- Source ROS setup scripts from common locations (and for bash too)
- Set up colcon command completion (for ROS 2)

Additionally:

- The `*-avahi` containers install packages and mount a directory and file to enable using Avahi mDNS/DNS-SD in the container (for looking up .local addresses)
- The `*-perception-tensorrt` containers install NVIDIA CUDA, TensorRT, and other dependencies, and run using NVIDIA Container Toolkit
- The `*-desktop-full` containers mount a directory and file to enable running graphical applications in the container
- The `*-desktop-full-nvdia` containers also add a file (`10_nvidia.json`) to enable NVIDIA GPU acceleration for graphical applications

## Prerequisites

- Ensure a recent version of [Docker Engine](https://docs.docker.com/engine/install/) (or Docker Desktop) is installed and can be [run by you](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user)
- For CUDA/TensorRT, install [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

## Basic usage

- Run a script in the bin folder to start a shell in the container:
```bash
./ros_humble_base
```
- The scripts can also be used to run a command directly:
```bash
./ros_humble_base ros2 topic list
```
- The container image is built only on the first run.
To build it again (e.g. if the Dockerfile has changed) use the `-b` option:
```bash
./ros_humble_base -b
```

## Environment variables

Environment variables are declared in [env files](https://docs.docker.com/reference/compose-file/services/#env_file), which will be set in the container if they are set on the host:

- `ros2.env`:
  - `ROS_DOMAIN_ID`
  - `ROS_AUTOMATIC_DISCOVERY_RANGE` (jazzy and later)
  - `ROS_LOCALHOST_ONLY` (humble and earlier)
  - `ROS_STATIC_PEERS`
  - `RMW_IMPLEMENTATION`
  - `RCUTILS_CONSOLE_OUTPUT_FORMAT`
  - `RCUTILS_COLORIZED_OUTPUT`
  - `RCUTILS_LOGGING_USE_STDOUT`
  - `RCUTILS_LOGGING_BUFFERED_STREAM`
- `ros1.env`:
  - `ROS_MASTER_URI`
  - `ROS_HOSTNAME`
  - `ROS_IP`
- `term.env`:
  - `TERM`
  - `COLORTERM`

Environment variables can be set statically in the [compose file](https://docs.docker.com/reference/compose-file/services/#environment) or in the env file.
For example if your terminal isn't supported in the container, the `TERM` variable can be set in the env file:

```
TERM=xterm-256color
```

## Making changes

### Scripts

Edit the scripts (located in `bin`) to:
- Change the project name or path
- Change the path to the home directory on the host
- Set environment variables that are evaluated at run time
- Run commands before running the container (like to ensure directories exist on the host)

### `Dockerfile`

Edit a container's [`Dockerfile`](https://docs.docker.com/reference/dockerfile/) to change how the image is built, e.g. to install additional packages.
[Dockerfile+](https://github.com/edrevo/dockerfile-plus) is used to add the `INCLUDE+` instruction that allows for importing a Dockerfile into another Dockerfile.

### `compose.yaml`

Edit a container's [`compose.yaml`](https://docs.docker.com/reference/compose-file/) file to change how the container is run, e.g.
- [Mount volumes](https://docs.docker.com/reference/compose-file/services/#volumes) (like a `ros2_ws`/`catkin_ws` folder)
- [Add devices](https://docs.docker.com/reference/compose-file/services/#devices)
- [Set environment variables](https://docs.docker.com/reference/compose-file/services/#environment)

## Tips

- Add the bin folder to your `PATH` environment variable to run the containers anywhere, e.g. by adding the following to `~/.bashrc` (replacing `/path/to/ros_docker` with the correct path):

```bash
export PATH="/path/to/ros_docker/bin:${PATH}"
```

- When building packages in a container you can use `rosdep` to find dependencies:

```bash
# Run from the workspace directory
rosdep check -i --from-paths src/
```
