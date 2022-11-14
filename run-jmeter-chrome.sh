#!/bin/sh

timestamp=$(date +%Y%m%d_%H%M%S)
volume_path=$(pwd)/share_folder
jmeter_path=/mnt/jmeter
TEST_NET=jmeter-distributed-network
docker_image_name=jmeter-chrome:5.5
test_plan_path_name=tests/test_plan_k6_test.jmx

docker run -it -v "${volume_path}":${jmeter_path} \
	--rm \
	${docker_image_name} \
    /bin/bash

# jmeter_path=/mnt/jmeter
# jmeter -n -t ${jmeter_path}/${test_plan_path_name} \
#   -l ${jmeter_path}/client/result_${timestamp}.csv \
#   -j ${jmeter_path}/client/jmeter_${timestamp}.log \
#   -e -o ${jmeter_path}/client/html-report_${timestamp}