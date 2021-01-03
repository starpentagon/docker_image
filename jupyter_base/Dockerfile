# Ubuntu 20.04 (focal)
# https://hub.docker.com/_/ubuntu/?tab=tags&name=focal
# OS/ARCH: linux/amd64
FROM ubuntu:focal-20201106@sha256:4e4bc990609ed865e07afc8427c30ffdddca5153fd4e82c20d8f0783a291e241

USER root

# Install jupyter notebook
RUN apt update \
 && apt -y upgrade \
 && apt -y install jupyter-notebook

# Jupyter notebook hashed password
## $ python3
## >>> from notebook.auth import passwd
## >>> passwd()
#
# or enter this docker container,
#
# $ docker run --rm -it jupyter_base
# 
# run the following script in the container,
#
# $ python3 scripts/pass.py
#ARG JUPYTER_PASSWD=''
ARG JUPYTER_PASSWD='sha1:e5007d4628a4:0713200de4f55dbf109b74597e390a3a9593e240'

# User name
ARG NB_USER='jupyter'

# Add user
ARG NB_UID="1000"
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

USER $NB_UID
WORKDIR /home/$NB_USER

# Copy the scripts for hash password and notebook server config.
COPY ./scripts /home/$NB_USER/scripts

# Generate a notebook server config
RUN jupyter notebook -y --generate-config
RUN ./scripts/notebook_config.sh $JUPYTER_PASSWD

# working directory
RUN mkdir work
WORKDIR /home/$NB_USER/work

# Port
EXPOSE 8888

