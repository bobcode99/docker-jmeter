# Make use of Docker with JMeter

This repository contains coded example published on Blazemeter starting from [link](https://www.blazemeter.com/blog/make-use-of-docker-with-jmeter-learn-how)


### Steps

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
./create-rmi-keystore.sh
mv rmi_keystore.jks
exit

docker rmi -f use-for-generate-rmi
```

#### start test

```bash
chmod +x docker_distributed_jmeter.sh
./docker_distributed_jmeter.sh
```

Ref:

https://www.blazemeter.com/blog/jmeter-distributed-testing-with-docker