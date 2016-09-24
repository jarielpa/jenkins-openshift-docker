FROM openshift/jenkins-1-centos7

USER root

ENV MAVEN_VERSION 3.3.9

RUN yum clean all && \
    export INSTALL_PKGS="nss_wrapper java-1.8.0-openjdk-headless \
        java-1.8.0-openjdk-devel nss_wrapper gettext tar git \
        which origin-clients" && \
    yum clean all && \
    yum -y --setopt=tsflags=nodocs install epel-release centos-release-openshift-origin && \
    yum install -y --setopt=tsflags=nodocs install $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all


# Install Maven
RUN curl -sL -o /tmp/maven.tar.gz \
      https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/${MAVEN_VERSION}/apache-maven-${MAVEN_VERSION}-bin.tar.gz
    
RUN mkdir -p /opt/tools && \
    cd /opt/tools && \
    tar xfz /tmp/maven.tar.gz && \
    mv /opt/tools/apache-maven-${MAVEN_VERSION} /opt/tools/maven && \
    chown -R 1001:0 /opt/tools

USER 1001