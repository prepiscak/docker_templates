#!/bin/bash

# if 8787 is already taken you have to bind to different port.
#options:
# -p bind port 8787 of the container (default for Rstudio) to 6666
# user/group ids are important for saving files if your id on the machine differs from default 1000:1000
# --volume=$(pwd):/home/$(whoami) bind your current working dir to /home/$(whoami) dir in docker; this will be created when container starts

docker run --rm \
        -p 6666:8787 \
	-e USER=$(whoami) \
	-e USERID=$(id -u) \
	-e GROUP=$(whoami) \
	-e GROUPID=$(id -g) \
        -e PASSWORD=<whatever password; not your actual account password!!!> \
        -e COMPUTER="$(hostname)" \
	--volume=$(pwd):/home/$(whoami) \
	--workdir="/home/$(whoami)" \
        corebioinf/dockrstudio:4.0.3-v1

