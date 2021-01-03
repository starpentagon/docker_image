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
# Set hashed password(ex. 'sha1:25e2bc817b10:917f1e38841d80dfa40535f60a88bc83c5228297')
## $ python3
## >>> from notebook.auth import passwd
## >>> passwd()
## 'sha1:25e2bc817b10:917f1e38841d80dfa40535f60a88bc83c5228297'
ARG JUPYTER_PASSWD=''

# User name
ARG NB_USER='subaru'    # Set your user name

# Add user
ARG NB_UID="1000"
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

USER $NB_UID
WORKDIR /home/$NB_USER

# Generate a notebook server config
RUN rm -rf .jupyter
RUN jupyter notebook --generate-config

# Modify server config
RUN mv .jupyter/jupyter_notebook_config.py .jupyter/jupyter_notebook_config.py.old \ 
&& cat .jupyter/jupyter_notebook_config.py.old | \
sed "s/^#c.NotebookApp.ip = 'localhost'/c.NotebookApp.ip = '*'/g" | \
sed "s/^#c.NotebookApp.open_browser = True/c.NotebookApp.open_browser = False/g" | \
sed "s/^#c.NotebookApp.port = 8888/c.NotebookApp.port = 8888/g" | \
sed "s/^#c.NotebookApp.password = ''/c.NotebookApp.password = '$JUPYTER_PASSWD'/g"> .jupyter/jupyter_notebook_config.py

# Hashed password script
RUN echo "from notebook.auth import passwd" > pass.py \
&& echo "" >> pass.py \
&& echo "print('Please set the following JUPYTER_PASSWD variable in Dockerfile.')" >> pass.py \
&& echo "print('ARG JUPYTER_PASSWD=\'{}\''.format(passwd()))" >> pass.py

# working directory
RUN mkdir work
WORKDIR /home/$NB_USER/work

# Port
EXPOSE 8888

