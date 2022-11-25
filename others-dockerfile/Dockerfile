FROM selenium/standalone-chrome-debug
EXPOSE 5900-6000
EXPOSE 4444-4544

# Install dependencies
USER root

# Install JDK
RUN apt-get -qq update
RUN apt-get -qq -y install software-properties-common
RUN \
  echo debconf shared/accepted-oracle-license-v1-2 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-2 seen true | debconf-set-selections && \
  add-apt-repository ppa:linuxuprising/java && \
  apt-get update && \
  apt-get install -qq -y default-jdk && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-java11-installer

# Install Maven
ARG MAVEN_VERSION=3.6.2
ARG USER_HOME_DIR="/root"
ARG SHA=3fbc92d1961482d6fbd57fbf3dd6d27a4de70778528ee3fb44aa7d27eb32dfdc
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && apt-get update \
  && apt-get -qq -y install curl \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha256sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

# Install JMeter
ARG JMETER_VERSION="5.1.1"
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN  ${JMETER_HOME}/bin
ENV JMETER_DOWNLOAD_URL https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_PLUGINS_MANAGER_VERSION 1.3
ENV CMDRUNNER_VERSION 2.2

RUN apt-get update && \
  apt-get install -qq -y curl unzip && \
  mkdir -p /tmp/dependencies && \
  curl -L --silent ${JMETER_DOWNLOAD_URL} > /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz && \
  mkdir -p /opt && \
  tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt && \
  rm -rf /tmp/dependencies

# Set global PATH such that "jmeter" command is found
ENV PATH $PATH:$JMETER_BIN

# Install JMeter Plugins
RUN curl --location --silent --show-error --output ${JMETER_HOME}/lib/ext/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar http://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-manager/${JMETER_PLUGINS_MANAGER_VERSION}/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar \
 && curl --location --silent --show-error --output ${JMETER_HOME}/lib/cmdrunner-${CMDRUNNER_VERSION}.jar http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/${CMDRUNNER_VERSION}/cmdrunner-${CMDRUNNER_VERSION}.jar \
 && curl --location --silent --show-error --output ${JMETER_HOME}/lib/json-lib-${JSON_LIB_FULL_VERSION}.jar https://search.maven.org/remotecontent?filepath=net/sf/json-lib/json-lib/${JSON_LIB_VERSION}/json-lib-${JSON_LIB_FULL_VERSION}.jar \
 && java -cp ${JMETER_HOME}/lib/ext/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar org.jmeterplugins.repository.PluginManagerCMDInstaller \
 &&  JVM_ARGS="-Dhttps.proxyHost=<proxyhost> -Dhttps.proxyPort=80"  PluginsManagerCMD.sh install-all-except

RUN curl --location --silent --show-error --output  ${JMETER_HOME}/lib/guava-19.0.0.jar http://search.maven.org/remotecontent?filepath=com/google/guava/guava/22.0/guava-22.0.jar

COPY launch.sh /

WORKDIR ${JMETER_HOME}

ENTRYPOINT ["/launch.sh"]