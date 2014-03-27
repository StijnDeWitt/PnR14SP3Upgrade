#!/bin/bash

PATH=/bin/:/usr/bin:$PATH

source $OPENSHIFT_CARTRIDGE_SDK_BASH

function ishttpup() {
    count=0
    while [ ${count} -lt 40 ]
    do
        if /usr/sbin/lsof -P -n -i "@${OPENSHIFT_PLN_IP}:${OPENSHIFT_PLN_HTTP_PORT_JBOSS}" | grep "(LISTEN)" > /dev/null; then
            echo "Found ${OPENSHIFT_PLN_IP}:${OPENSHIFT_PLN_HTTP_PORT} listening port"
            sleep 10
            return 0
        fi
        let count=${count}+1

        sleep 2
    done
    return 1
}

function startUpgrade(){
  ishttpup
  JAVAOPTIONS="-Djava.security.auth.login.config=$OPENSHIFT_PLN_DIR/PlanonProCenter/ProCenterClient/auth.conf"
  MAINCLASS="nl.planon.heracles.client.application.UpgradeTool"
  MODE="-upgradeAll -batch"

  cd $OPENSHIFT_PLN_DIR/PlanonProCenter/ProCenterClient/

  CLASSPATH=$(JARS=("$LIB"/$OPENSHIFT_PLN_DIR/PlanonProCenter/ProCenterClient/*.jar); IFS=:; echo "${JARS[*]}")

  java -cp $CLASSPATH $JAVAOPTIONS $MAINCLASS $MODE 2> $OPENSHIFT_PLN_DIR/logs/upgrade-swing-errors.log > $OPENSHIFT_PLN_DIR/logs/upgrade-swing.log

  client_result "   Update(Swing) run.sh executed"

  exit 0
}

case "$1" in
  startUpgrade) startUpgrade ;;
  ishttpup)     ishttpup ;;	
  *)            exit 0
esac
