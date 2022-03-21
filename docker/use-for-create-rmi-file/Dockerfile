# 1
FROM alpine:3.15
# 2
LABEL maintainer="yb"

#https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.4.3.tgz
# 3 
ARG JMETER_VERSION="5.4.3"

# 4
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN  ${JMETER_HOME}/bin
ENV MIRROR_HOST https://archive.apache.org/dist/jmeter
ENV JMETER_DOWNLOAD_URL ${MIRROR_HOST}/binaries/apache-jmeter-${JMETER_VERSION}.tgz

# 5
RUN    apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
    && apk add --update openjdk8-jre tzdata curl unzip bash \
    && cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime \
    && echo "Asia/Taipei" >  /etc/timezone \
	&& rm -rf /var/cache/apk/* \
	&& mkdir -p /tmp/dependencies  \
	&& curl -L --silent ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz  \
	&& mkdir -p /opt  \
	&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
	&& rm -rf /tmp/dependencies

# 7
ENV PATH $PATH:$JMETER_BIN

# # 8
# COPY launch.sh /
# COPY java.policy ${JMETER_HOME}/bin

# RUN ["chmod", "+x", "/launch.sh"]

#9
WORKDIR ${JMETER_HOME}

# #10
# ENTRYPOINT ["/launch.sh"]
