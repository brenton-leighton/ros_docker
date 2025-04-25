# Add a user to the image

ARG USER_ID
ARG USER

# Jazzy has a user named ubuntu with id 1000
# Delete it if it conflicts with the user to be added
RUN if id ${USER_ID} > /dev/null 2>&1; then userdel -r $(id -nu ${USER_ID}); fi

# Add host user
RUN useradd -m -u ${USER_ID} -s /bin/bash ${USER}

# Ensure files from skel exist in mounted volumes
RUN bash -c "echo -e \\\ncp -an /etc/skel/. \$\{HOME\} >> /etc/bash.bashrc"

USER ${USER}
WORKDIR /home/${USER}
