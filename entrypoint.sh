#!/bin/bash
cp ${PERSON_HOME}/person.jar bin/sample.jar
java ${JVM_ARGS} -jar -Dserver.port=9000 bin/sample.jar