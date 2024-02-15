FROM mcr.microsoft.com/devcontainers/base:bullseye

WORKDIR /development

RUN apt-get update && \
    apt-get install -y git wget jq zip

# COPY requirements.txt requirements.txt

# RUN python3 -m pip install --upgrade pip && \
#     python3 -m pip install -r requirements.txt

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
RUN unzip /tmp/awscliv2.zip -d /tmp/
RUN /tmp/aws/install
RUN wget https://releases.hashicorp.com/terraform/1.1.2/terraform_1.1.2_linux_amd64.zip -O ~/terraform.zip
RUN unzip ~/terraform.zip -d ~/ && sudo mv ~/terraform /usr/local/bin/terraform
    
