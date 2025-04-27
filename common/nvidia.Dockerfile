# Use NVIDIA graphics for GUI applications

# Copy 10_nvidia.json into the container
# https://github.com/osrf/rocker/blob/main/src/rocker/templates/nvidia_snippet.Dockerfile.em
COPY common/10_nvidia.json /usr/share/glvnd/egl_vendor.d/
