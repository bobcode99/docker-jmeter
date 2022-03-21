# Make use of Docker with JMeter

This repository contains coded example published on Blazemeter starting from [link](https://www.blazemeter.com/blog/make-use-of-docker-with-jmeter-learn-how)


### Steps

Need download docker first.
#### build docker images
```bash
docker build -t jmeter-test:5.4.3 .
docker build -t use-for-generate-rmi .
```
#### create rmi key

https://jmeter.apache.org/usermanual/remote-test.html#setup_ssl

```bash
docker run --rm -it --volume $(pwd)/share_folder:/mnt/jmeter use-for-generate-rmi /bin/sh

cd bin/
sh create-rmi-keystore.sh
mv rmi_keystore.jks
exit

docker rmi -f use-for-generate-rmi
```

> note: in windows can use Git Bash to execute `*.sh` files
> https://stackoverflow.com/questions/26522789/how-to-run-sh-on-windows-command-prompt

#### start test

```bash
chmod +x docker_distributed_jmeter.sh
sh docker_distributed_jmeter.sh
```

Ref:

https://www.blazemeter.com/blog/jmeter-distributed-testing-with-docker

https://jmeter.apache.org/usermanual/jmeter_distributed_testing_step_by_step.html

https://jmeter.apache.org/usermanual/remote-test.html

https://stackoverflow.com/questions/3150448/jmeter-loopback-address-error-when-launching-jmeter-server-on-linux