#!/bin/bash

JAVAOPTIONS=-Djava.security.auth.login.config=.\auth.conf

MAINCLASS="nl.planon.heracles.client.application.UpgradeTool"

MODE=-upgradeAll

CLASSPATH=$(JARS=("$LIB"/*.jar); IFS=:; echo "${JARS[*]}")

java -cp $CLASSPATH $JAVAOPTIONS $MAINCLASS $MODE > %1

