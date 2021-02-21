# Generate a hashed password.
from notebook.auth import passwd

hashed_passwd = passwd()

print('')
print('Please set the following JUPYTER_PASSWD variable in Dockerfile.')
print('')
print("ARG JUPYTER_PASSWD='{}'".format(hashed_passwd))
print('')

