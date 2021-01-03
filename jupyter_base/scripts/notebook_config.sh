#!/bin/bash
hashed_passwd=$1
config=~/.jupyter/jupyter_notebook_config.py

mv $config $config.old

cat $config.old | \
sed "s/^#c.NotebookApp.ip = 'localhost'/c.NotebookApp.ip = '*'/g" | \
sed "s/^#c.NotebookApp.open_browser = True/c.NotebookApp.open_browser = False/g" | \
sed "s/^#c.NotebookApp.port = 8888/c.NotebookApp.port = 8888/g" | \
sed "s/^#c.NotebookApp.password = ''/c.NotebookApp.password = '$hashed_passwd'/g" > $config


