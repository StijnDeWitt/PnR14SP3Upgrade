#!/bin/bash

JAVAOPTIONS=-Djava.security.auth.login.config=.\auth.conf

MAINCLASS="nl.planon.heracles.client.application.UpgradeTool"

MODE=-upgradeAll

CLASSPATH=$(JARS=("$LIB"/$OPENSHIFT_PLN_DIR/PlanonProCenter/ProCenterClient/*.jar); IFS=:; echo "${JARS[*]}")

java -cp $CLASSPATH $JAVAOPTIONS $MAINCLASS $MODE > %$OPENSHIFT_PLN_DIR/logs/upgrade-swing.log 

