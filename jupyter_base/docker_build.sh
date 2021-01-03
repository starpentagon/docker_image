#!/bin/bash

# build the image
docker build -t jupyter_base .

# Check the hashed passwaord is set by user in Dockerfile.
while read line
do
	if [[ $line == "ARG JUPYTER_PASSWD=''" ]]; then
		# Notice user to set jupyter notenook password
		echo "The jupyter notebook password is not set in the Dockerfile. To obtain the hashed password, run the image:"
		echo ""
		echo "  $ docker run --rm -it jupyter_base"
		echo ""
		echo "Run the following python script and enter your password."
		echo ""
		echo "  $ python3 ~/pass.py"
		echo ""
		echo "Then, the script outpus the hashed password, please copy it."
		echo ""
		echo "Exit from the docker container."
		echo "  $ exit"
		echo ""
		echo "Please set JUPYTER_PASSWD variable in the Dockerfile."
		echo "ex. ARG JUPYTER_PASSWD='sha1:25e2bc817b10:917f1e38841d80dfa40535f60a88bc83c5228297'"
		echo ""
		echo "Finally, build the docker image, again."
		echo ""
		echo "  $ ./docker_build.sh"
		exit 1
	fi
done < ./Dockerfile

