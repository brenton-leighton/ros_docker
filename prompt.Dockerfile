# Prepend the project name to the prompt

ARG COMPOSE_PROJECT_NAME

RUN bash -c "echo -e \\\nexport PS1=\\\"\(\${COMPOSE_PROJECT_NAME}\) \$\{PS1\}\\\" >> /etc/skel/.bashrc"
