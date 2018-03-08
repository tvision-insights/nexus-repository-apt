FROM maven:3-jdk-8-alpine

ARG NEXUS_BUILD=01
ARG NEXUS_VERSION=3.9.0

VOLUME ["/target"]

COPY . /nexus-repository-apt/

RUN sed -i "s/3.9.0-01/${NEXUS_VERSION}-${NEXUS_BUILD}/g" /nexus-repository-apt/pom.xml

RUN echo -e '#!/bin/bash\nmvn package && rm -rf /root/.m2 && cp ./target/nexus-repository-apt-*.jar /target' >> /usr/bin/nexus-repository-apt-build && \
    chmod 755 /usr/bin/nexus-repository-apt-build

WORKDIR /nexus-repository-apt

ENTRYPOINT ["/usr/bin/nexus-repository-apt-build"]
