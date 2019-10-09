# Set the base image to java8
FROM openjdk:8-alpine

# File Author
MAINTAINER motomohan

# Define default environment variables
ENV APP_HOME=/opt
ENV APP_BINARIES=/opt/bin

# Create directory
RUN mkdir -p $APP_BINARIES

# Set default directory
WORKDIR $APP_HOME

# Copy notepad jar file
COPY build/libs/*.jar $APP_HOME/sample.jar

# Add initialization script
ADD entrypoint.sh $APP_BINARIES/entrypoint.sh

# Give permissions
RUN chmod 755 $APP_BINARIES/entrypoint.sh

# Give permissions
RUN chmod 755 $APP_HOME/sample.jar

# Expose default servlet container port
EXPOSE 9000

VOLUME bin

# Main command
ENTRYPOINT ["/bin/sh", "/opt/bin/entrypoint.sh"]