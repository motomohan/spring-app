FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
VOLUME /tmp
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn package

FROM openjdk:8-jdk-alpine

ARG JAR_FILE
COPY --from=MAVEN_TOOL_CHAIN /tmp/target/sample-0.0.1-SNAPSHOT.jar /app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]