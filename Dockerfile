FROM ubuntu:20.04
ARG TERRAFORM_VERSION=1.2.4
ARG TERRAGRUNT_VERSION=0.42.8
ARG VAULT_VERSION=1.13.4

# Update apt and Install dependencies
RUN apt-get update && apt install software-properties-common -y && add-apt-repository ppa:rmescandon/yq -y && apt update && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y \
    tzdata \
    curl \
    dnsutils \
    git \
    jq \
    yq \
    libssl-dev \
    openvpn \
    python3 \
    python3-pip \
    screen \
    vim \
    wget \
    zip \
    mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Install tools and configure the environment
RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin/ \
    && rm /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN wget -q https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -O /bin/terragrunt \
    && chmod +x /bin/terragrunt
RUN wget -q https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -O /tmp/vault_${VAULT_VERSION}_linux_amd64.zip \
    && unzip /tmp/vault_${VAULT_VERSION}_linux_amd64.zip -d /bin/ \
    && rm /tmp/vault_${VAULT_VERSION}_linux_amd64.zip

RUN pip3 install --upgrade pip \
    && mkdir /workdir && cd /workdir \
    && mkdir keys \
    && python3 -m pip install ansible==5.7.1 netaddr awscli openshift>=0.6 setuptools>=40.3.0 \
    && ansible-galaxy collection install community.kubernetes

COPY . iac-run-dir