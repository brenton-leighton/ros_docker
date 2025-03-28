# Add a user to the image

ARG UID
ARG USER

# Jazzy has a user named ubuntu with id 1000
# Delete it if it conflicts with the user to be added
RUN if id ${UID} > /dev/null 2>&1; then userdel -r $(id -nu ${UID}); fi

RUN useradd -m -u ${UID} -s /bin/bash ${USER}
USER ${USER}

WORKDIR /home/${USER}
