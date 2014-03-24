#!/bin/bash

JAVAOPTIONS="-Djava.security.auth.login.config=$OPENSHIFT_PLN_DIR/PlanonProCenter/ProCenterClient/auth.conf -server"

MAINCLASS="nl.planon.heracles.client.application.UpgradeTool"

MODE="-upgradeAll -batch -nologfile -exitshell"

cd $OPENSHIFT_PLN_DIR/PlanonProCenter/ProCenterClient/

CLASSPATH=$(JARS=("$LIB"/$OPENSHIFT_PLN_DIR/PlanonProCenter/ProCenterClient/*.jar); IFS=:; echo "${JARS[*]}")

java -cp $CLASSPATH $JAVAOPTIONS $MAINCLASS $MODE 0< /dev/null 2> $OPENSHIFT_PLN_DIR/logs/upgrade-swing-errors.log > $OPENSHIFT_PLN_DIR/logs/upgrade-swing.log &


