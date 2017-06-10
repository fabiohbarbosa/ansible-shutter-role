#!/bin/bash
pwd=`pwd`/../../../
volume="$pwd:/tmp/environment-setup"
image_name="ansible-shutter-role"

docker build -t $image_name . && docker run -v $volume --rm -i -t $image_name