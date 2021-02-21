# CUDA 11.2 base Ubuntu 20.04
FROM nvidia/cuda:11.2.1-base-ubuntu20.04
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
# $ docker run --rm -it nvidia
# 
# run the following script in the container,
#
# $ python3 scripts/pass.py
ARG JUPYTER_PASSWD=''

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

