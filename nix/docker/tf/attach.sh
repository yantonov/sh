#!/bin/sh

image_id=`docker ps | grep 'tensorflow/tensorflow' | awk '{print $1}'`

sudo docker exec -i -t $image_id /bin/bash
