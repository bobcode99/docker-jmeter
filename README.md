# Make use of Docker with JMeter

This repository contains coded example published on Blazemeter starting from [link](https://www.blazemeter.com/blog/make-use-of-docker-with-jmeter-learn-how)


### Steps

Need download docker first.
#### build docker images
```bash
docker build -t jmeter-test1:5.4.3 .

cd docker/use-for-create-rmi-file
docker build -t use-for-generate-rmi .
cd ..
```
#### generate rmi key

https://jmeter.apache.org/usermanual/remote-test.html#setup_ssl

```bash
# run use-for-generate-rmi container to generate rmi key
docker run --rm -it --volume $(pwd)/share_folder:/mnt/jmeter use-for-generate-rmi /bin/sh

# inside the docker container
# generate rmi_keystore.jks file, move to mount folder
cd bin/
# key in the information
sh create-rmi-keystore.sh
# move to mount share folder
mv rmi_keystore.jks /mnt/jmeter/rmi_keystore.jks
exit

# delete docker image
docker rmi -f use-for-generate-rmi
```

> note: in windows can use Git Bash to execute `*.sh` files
> 
> https://stackoverflow.com/questions/26522789/how-to-run-sh-on-windows-command-prompt

#### start test

```bash
# give execute access
chmod +x docker_distributed_jmeter.sh

# run shell script start testing
sh docker_distributed_jmeter.sh
```

Ref:

https://www.blazemeter.com/blog/jmeter-distributed-testing-with-docker

https://jmeter.apache.org/usermanual/jmeter_distributed_testing_step_by_step.html

https://jmeter.apache.org/usermanual/remote-test.html

https://stackoverflow.com/questions/3150448/jmeter-loopback-address-error-when-launching-jmeter-server-on-linux
