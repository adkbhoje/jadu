FROM ubuntu:16.04

ARG TAG=hi
ENV env_var_name=$TAG

ARG AWS_ACCESS_KEY_ID=test
ENV access_key=$AWS_ACCESS_KEY_ID

ARG AWS_SECRET_ACCESS_KEY=test2
ENV secret_key=$AWS_SECRET_ACCESS_KEY

RUN apt-get update && apt-get install -y \
    wget \
    unzip \
	ntp \
  && rm -rf /var/lib/apt/lists/*
  
RUN wget --quiet https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip \
  && unzip terraform_0.11.3_linux_amd64.zip \
  && mv terraform /usr/bin \
  && rm terraform_0.11.3_linux_amd64.zip
RUN echo `pwd`
RUN echo `ls -las`
RUN echo `ntpq -p`
RUN echo $access_key
RUN echo $secret_key
