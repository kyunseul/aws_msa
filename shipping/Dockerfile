FROM 009543462659.dkr.ecr.ap-northeast-2.amazonaws.com/java

WORKDIR /usr/src/app
COPY ./dd-java-agent.jar ./dd-java-agent.jar
COPY target/*.jar ./app.jar

RUN chown -R ${SERVICE_USER}:${SERVICE_GROUP} ../app

USER ${SERVICE_USER}

RUN	mkdir log && chown -R ${SERVICE_USER}:${SERVICE_GROUP} ./log

ARG BUILD_DATE
ARG BUILD_VERSION
ARG COMMIT

LABEL org.label-schema.vendor="Weaveworks" \
  org.label-schema.build-date="${BUILD_DATE}" \
  org.label-schema.version="${BUILD_VERSION}" \
  org.label-schema.name="Socks Shop: Shipping" \
  org.label-schema.description="REST API for Shipping service" \
  org.label-schema.url="https://github.com/microservices-demo/shipping" \
  org.label-schema.vcs-url="github.com:microservices-demo/shipping.git" \
  org.label-schema.vcs-ref="${COMMIT}" \
  org.label-schema.schema-version="1.0"

ENTRYPOINT ["/usr/local/bin/java.sh", "-javaagent:dd-java-agent.jar", "-jar","./app.jar", "--port=80"]
