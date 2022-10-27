# 1
FROM alpine:3.15
# 2
LABEL maintainer="yb"

#https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.4.3.tgz
# 3 
ARG JMETER_VERSION="5.5"

# 4
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN  ${JMETER_HOME}/bin
ENV MIRROR_HOST https://archive.apache.org/dist/jmeter
ENV JMETER_DOWNLOAD_URL ${MIRROR_HOST}/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_PLUGINS_DOWNLOAD_URL http://insecure.repo1.maven.org/maven2/kg/apc
ENV CMDRUNNER_VERSION 2.3
ENV JMETER_PLUGINS_FOLDER ${JMETER_HOME}/lib/ext/
ENV JMETER_PLUGINS_MANAGER_VERSION 1.8

# 5
RUN    apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
    && apk add --update openjdk11-jre tzdata curl unzip bash \
    && cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime \
    && echo "Asia/Taipei" >  /etc/timezone \
	&& rm -rf /var/cache/apk/* \
	&& mkdir -p /tmp/dependencies  \
	&& curl -L --silent ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz  \
	&& mkdir -p /opt  \
	&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
	&& rm -rf /tmp/dependencies

# 6
# download plugin
# RUN curl -L ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-dummy/0.2/jmeter-plugins-dummy-0.2.jar -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-dummy-0.2.jar
# RUN curl -L ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-cmn-jmeter/0.5/jmeter-plugins-cmn-jmeter-0.5.jar -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-cmn-jmeter-0.5.jar
# download Concurrency Thread Group plugin
# RUN curl -L ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-casutg/2.10/jmeter-plugins-casutg-2.10.jar -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-casutg-2.10.jar

RUN wget ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-manager/${JMETER_PLUGINS_MANAGER_VERSION}/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar -O $JMETER_HOME/lib/ext/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar \
 && wget ${JMETER_PLUGINS_DOWNLOAD_URL}/cmdrunner/$CMDRUNNER_VERSION/cmdrunner-$CMDRUNNER_VERSION.jar -O $JMETER_HOME/lib/cmdrunner-$CMDRUNNER_VERSION.jar \
 && java -cp $JMETER_HOME/lib/ext/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar org.jmeterplugins.repository.PluginManagerCMDInstaller \
 && cd ${JMETER_HOME}/bin && ./PluginsManagerCMD.sh install jpgc-mergeresults \
 && cd ${JMETER_HOME}/bin && ./PluginsManagerCMD.sh install jpgc-synthesis \
 && cd ${JMETER_HOME}/bin && ./PluginsManagerCMD.sh install jpgc-cmd \
 && cd ${JMETER_HOME}/bin && ./PluginsManagerCMD.sh install jpgc-casutg \
 && cd ${JMETER_HOME}/bin && ./PluginsManagerCMD.sh install bzm-http2

# 7
ENV PATH $PATH:$JMETER_BIN

# 8
COPY launch.sh /
COPY jmeter.properties ${JMETER_BIN}
COPY java.policy ${JMETER_HOME}/bin

RUN ["chmod", "+x", "/launch.sh"]

#9
WORKDIR ${JMETER_HOME}

#10
ENTRYPOINT ["/launch.sh"]
