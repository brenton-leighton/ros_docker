# ros_docker

Example containers for working with ROS in Docker.
Some functionality is identical to [rocker](https://github.com/osrf/rocker), but other things are only possible by defining the containers.

The scripts used to start the containers are fairly trivial, and the containers can be [run directly from the compose files by replacing some variables](#running-the-containers-directly) (e.g. to run the containers from an IDE).

All the containers:

- Run as the current user
- Set environment variables from the host
- Mount a host directory as the home directory in the container, to allow for persistent bash history, configuration files, etc.
- Source ROS setup scripts from common locations (and for bash too)
- Set up colcon command completion (for ROS 2)

Additionally:

- The `*-avahi` containers allow for using Avahi mDNS/DNS-SD in the container (for looking up .local addresses)
- The `*-perception-tensorrt` containers install NVIDIA CUDA, TensorRT, and other dependencies, and run using NVIDIA Container Toolkit
- The `*-desktop-full` containers allow for running graphical applications in the container
- The `*-desktop-full-nvdia` containers allow for running graphical applications in the container with NVIDIA GPU acceleration

## Prerequisites

- Ensure a recent version of [Docker Engine](https://docs.docker.com/engine/install/) (or Docker Desktop) is installed and can be [run by you](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user)
- For CUDA/TensorRT or NVIDIA GPU acceleration of graphical applications, install [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

## Basic usage

- Run a script in the bin directory to start a shell in a container:
```bash
./ros_humble_base
```
- The scripts can also be used to run a command directly in a container:
```bash
./ros_humble_base ros2 topic list
```
- The container image will only be built on the first run.
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

There are additional variables for specific ROS 2 middleware in `ros2.env` that are not listed here.

Variables can be set statically in the env files or in a project's [compose file](https://docs.docker.com/reference/compose-file/services/#environment).
Variables in the compose file take precedence over the env files.

## Making changes

Scripts to run the containers are located in the `bin` directory.
The `compose.yaml` and `Dockerfile` files that define the containers are located in project directories, which are organised by ROS distribution.
There are additional files for building the containers located in the `common` directory.

### Scripts

Edit the scripts to:
- Change the project directory
- Set environment variables that are evaluated at run time
- Run commands before running the container (like to ensure directories exist on the host)

### `compose.yaml`

Edit a container's [`compose.yaml`](https://docs.docker.com/reference/compose-file/) file to change how the container is run, e.g.
- [Mount volumes](https://docs.docker.com/reference/compose-file/services/#volumes) (like a `ros2_ws`/`catkin_ws` directory) or change the location of the home directory on the host
- [Set environment variables](https://docs.docker.com/reference/compose-file/services/#environment)
- [Add devices](https://docs.docker.com/reference/compose-file/services/#devices)
- [Enable privileged](https://docs.docker.com/reference/compose-file/services/#privileged) (although bear in mind that [this is not recommended](https://docs.docker.com/reference/cli/docker/container/run/#privileged) and will break devices using symbolic links)

### `Dockerfile`

Edit a container's [`Dockerfile`](https://docs.docker.com/reference/dockerfile/) to change how the image is built, e.g. to install additional packages.

[Dockerfile+](https://github.com/edrevo/dockerfile-plus) is used to add the `INCLUDE+` instruction that allows for importing a Dockerfile into another Dockerfile.

## Running the containers directly

The containers can be run directly from the compose file, however:
- You should run the container from the script at least once to ensure the home directory exists on the host (if not, it will be created by the root user)
- If your ID on the host is not 1000 (if you are the first or only user it should be 1000) you need to either set the `USER_ID` variable or edit the value in the compose files
- The GUI containers (with `desktop` in their names) should probably not be run directly because the scripts do some additional checks of variables and directories

The containers can also be run from a [`devcontainer`](https://containers.dev/), e.g.:

```json
{
    "name": "ros-humble-base",
    "dockerComposeFile": "/path/to/ros_docker/humble/ros-humble-base/compose.yaml",
    "service": "default",
    "mounts": [
        {
            "source": "${localWorkspaceFolder}",
            "target": "${localEnv:HOME}/ros2_ws/src/${localWorkspaceFolderBasename}",
            "type": "bind"
        }
    ],
    "workspaceFolder": "${localEnv:HOME}/ros2_ws/src/${localWorkspaceFolderBasename}"
}
```

## Tips

- Add the bin directory to your `PATH` environment variable to run the containers anywhere, e.g. by adding the following to `~/.bashrc` (replacing `/path/to/ros_docker` with the correct path):

```bash
export PATH="/path/to/ros_docker/bin:${PATH}"
```

- If your terminal isn't supported in the container, the `TERM` variable can be set in `term.env`:

```
TERM=xterm-256color
```

- When building packages in a container you can use `rosdep` to find dependencies:

```bash
# Run from the workspace directory
rosdep check -i --from-paths src/
```
