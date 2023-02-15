#!/bin/bash
timestamp=$(date +%Y%m%d_%H%M%S)
volume_path=$(pwd)/share_folder
jmeter_path=/mnt/jmeter
docker_image_name=jmeter-chrome-109-debug-sideex:5.5
test_plan_path_name=tests/testPlanSideexLinux_for_docker.jmx


docker run \
  -it \
  -v "${volume_path}":${jmeter_path} \
  -e jmeter_path='/mnt/jmeter' \
  -e timestamp=$(date +%Y%m%d_%H%M%S) \
  -e test_plan_path_name='tests/testPlanSideexLinux_for_docker.jmx' \
  -p 8888:4444 \
  --rm \
  ${docker_image_name} \
  /bin/bash


# docker run \
#   -v "${volume_path}":${jmeter_path} \
#   --rm \
#   ${docker_image_name} \
#   -n -X \
#   -Djava.security.manager \
#   -Djava.security.policy=${JMETER_HOME}/bin/java.policy \
#   -Djmeter.home=${JMETER_HOME} \
#   -t ${jmeter_path}/${test_plan_path_name} \
#     -l ${jmeter_path}/client/result_${timestamp}.csv \
#   -j ${jmeter_path}/client/jmeter_${timestamp}.log \
#     -e -o ${jmeter_path}/client/html-report_${timestamp}