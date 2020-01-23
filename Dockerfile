FROM ubuntu:18.10

COPY ./.bashrc /root/.bashrc
COPY ./.bash_profile /root/.bash_profile

RUN apt-get update && apt-get -y install \
    gnupg \
    curl \
    git \
    bash-completion \
    apt-transport-https

# Install kubectl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && apt-get install -y kubectl

# Configure auto-complete for bash
RUN /bin/bash echo "source <(kubectl completion bash)" >> ~/.bashrcource <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first. \
    /bin/bash source ~/.bashrc # add autocomplete permanently to your bash shell.

ENV SHELL /usr/bin/bash

WORKDIR /root
ENTRYPOINT ["/bin/bash"]