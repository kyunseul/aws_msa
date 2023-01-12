FROM  009543462659.dkr.ecr.ap-northeast-2.amazonaws.com/java
# weaveworksdemos/msd-java:jre-latest

WORKDIR /usr/src/app
COPY ./dd-java-agent.jar ./dd-java-agent.jar
COPY ./target/*.jar ./app.jar

RUN	chown -R ${SERVICE_USER}:${SERVICE_GROUP} ./app.jar

USER ${SERVICE_USER}

ENTRYPOINT ["/usr/local/bin/java.sh", "-javaagent:dd-java-agent.jar","-jar","./app.jar", "--port=80"]
