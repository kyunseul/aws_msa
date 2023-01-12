FROM openjdk:8-jdk-alpine

ENV	SERVICE_USER=myuser \
	SERVICE_UID=10001 \
	SERVICE_GROUP=mygroup \
	SERVICE_GID=10001

RUN	addgroup -g ${SERVICE_GID} ${SERVICE_GROUP} && \
	adduser -g "${SERVICE_NAME} user" -D -H -G ${SERVICE_GROUP} -s /sbin/nologin -u ${SERVICE_UID} ${SERVICE_USER} && \
	apk add --update libcap && \
	mkdir /lib64 && \
	ln -s /usr/lib/jvm/java-11-openjdk-11.0.16.0.8-1.amzn2.0.1.x86_64/lib/server/libjvm.so /lib/libjvm.so && \
	ln -s /usr/lib/jvm/java-11-openjdk-11.0.16.0.8-1.amzn2.0.1.x86_64/lib/jli/libjli.so /lib/libjli.so && \
	sudo setcap 'cap_net_bind_service=+ep' $(readlink -f $(which java)); exit 0

WORKDIR /usr/src/app
COPY ./dd-java-agent.jar ./dd-java-agent.jar
COPY ./target/*.jar ./app.jar

RUN	sudo chown -R ${SERVICE_USER}:${SERVICE_GROUP} ./app.jar; exit 0

USER ${SERVICE_USER}

ENTRYPOINT ["java", "-javaagent:dd-java-agent.jar", "-Djava.security.egd=file:/dev/urandom","-jar","./app.jar", "--port=80"]
