# CUDA 11.2 base Ubuntu 20.04
FROM nvidia/cuda:11.2.1-base-ubuntu20.04
ARG DEBIAN_FRONTEND=noninteractive
ARG DEBCONF_NOWARNINGS=yes

USER root

# Install jupyter notebook
RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get -y --no-install-recommends install jupyter-notebook \
 && apt-get -y --no-install-recommends install python3-pip \
 && apt-get -y --no-install-recommends install cuda-11-0 \
 && apt-get -y --no-install-recommends install libcudnn8

# Install matplotlib, tensorflow and sklearn
RUN pip3 install tensorflow matplotlib scikit-learn
RUN pip3 install pandas

# Jupyter notebook hashed password
## $ python3
## >>> from notebook.auth import passwd
## >>> passwd()
#
# or enter this docker container,
#
# $ docker run --rm -it nvidia_docker_base
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

