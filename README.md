# ros_docker

Files for working with ROS in Docker

## Usage

- Install [Docker Engine](https://docs.docker.com/engine/install/) and also [set up the `docker` group](https://docs.docker.com/engine/install/linux-postinstall/)
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
