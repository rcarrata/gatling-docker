FROM openjdk:11

ENV GATLING_VERSION 3.2.1
ENV GATLING_HOME /opt/gatling
ENV PATH /opt/gatling/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR  /opt/gatling

RUN useradd gatling

RUN mkdir -p /tmp/downloads && \
  curl -sf -o /tmp/downloads/gatling-$GATLING_VERSION.zip \
  -L https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/$GATLING_VERSION/gatling-charts-highcharts-bundle-$GATLING_VERSION-bundle.zip && \
  mkdir -p /tmp/archive && cd /tmp/archive && \
  unzip /tmp/downloads/gatling-$GATLING_VERSION.zip && \
  mv /tmp/archive/gatling-charts-highcharts-bundle-$GATLING_VERSION/* /opt/gatling/ && \
  chown -R gatling:gatling /opt/gatling

VOLUME ["/opt/gatling/conf","/opt/gatling/results","/opt/gatling/user-files"]

USER gatling

ENTRYPOINT ["/opt/gatling/bin/gatling.sh"]

