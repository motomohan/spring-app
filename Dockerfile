FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
VOLUME /tmp
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn package

FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAR_FILE
COPY /temp/target/sample*.jar /app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]