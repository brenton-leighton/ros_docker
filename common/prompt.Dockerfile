# Prepend the project name to the prompt

ARG COMPOSE_PROJECT_NAME
ENV COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME}"

RUN bash -c "echo -e \\\n\
if \[ -n \\\"\\\${COMPOSE_PROJECT_NAME}\\\" \]\; then\\\n\
  export PS1=\\\"\[\\\${COMPOSE_PROJECT_NAME}\] \$\{PS1\}\\\"\\\n\
fi\
>> /etc/skel/.bashrc"
