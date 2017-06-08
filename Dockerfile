FROM openshift/jenkins-2-centos7

USER root

ENV MAVEN_VERSION 3.3.9


COPY ./configuration /opt/openshift/configuration

# Install Maven
RUN curl -sL -o /tmp/maven.tar.gz \
      https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/${MAVEN_VERSION}/apache-maven-${MAVEN_VERSION}-bin.tar.gz
    
RUN mkdir -p /opt/tools && \
    cd /opt/tools && \
    tar xfz /tmp/maven.tar.gz && \
    mv /opt/tools/apache-maven-${MAVEN_VERSION} /opt/tools/maven && \
    chown -R 1001:0 /opt/tools

USER 1001