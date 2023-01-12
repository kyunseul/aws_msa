FROM openjdk:8-jdk-alpine

WORKDIR /usr/src/app
COPY ./dd-java-agent.jar ./dd-java-agent.jar
COPY ./target/*.jar ./app.jar


ENTRYPOINT ["java", "-javaagent:dd-java-agent.jar", "-Djava.security.egd=file:/dev/urandom","-jar","./app.jar","--port=80"]