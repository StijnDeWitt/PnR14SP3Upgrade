#!/bin/bash

source $OPENSHIFT_CARTRIDGE_SDK_BASH

JAVAOPTIONS="-Djava.security.auth.login.config=$OPENSHIFT_PLN_DIR/PlanonProCenter/ProCenterClient/auth.conf"

MAINCLASS="nl.planon.heracles.client.application.UpgradeTool"

MODE="-upgradeAll -batch"

cd $OPENSHIFT_PLN_DIR/PlanonProCenter/ProCenterClient/

CLASSPATH=$(JARS=("$LIB"/$OPENSHIFT_PLN_DIR/PlanonProCenter/ProCenterClient/*.jar); IFS=:; echo "${JARS[*]}")

java -cp $CLASSPATH $JAVAOPTIONS $MAINCLASS $MODE 2> $OPENSHIFT_PLN_DIR/logs/upgrade-swing-errors.log > $OPENSHIFT_PLN_DIR/logs/upgrade-swing.log &

client_result "   Update(Swing) run.sh executed"
