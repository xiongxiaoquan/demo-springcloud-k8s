#!/bin/bash
postFix="svc.cluster.local"
EUREKA_INSTANCE_HOSTNAME="$MY_POD_NAME.$MY_IN_SERVICE_NAME.$MY_POD_NAMESPACE.$postFix"
export EUREKA_INSTANCE_HOSTNAME=$EUREKA_INSTANCE_HOSTNAME
BOOL_REGISTER="true"
BOOL_FETCH="true"
if [ $EUREKA_REPLICAS = 1 ]; then
    echo "the replicas of eureka pod is one"
    BOOL_REGISTER="false"
    BOOL_FETCH="false"
    EUREKA_SERVER="http://$EUREKA_INSTANCE_HOSTNAME:8761/eureka/,"
    echo " set the EUREKA_URL_LIST is $EUREKA_SERVER"
else
    echo "the replicas of the eureka pod is $EUREKA_REPLICAS"
    BOOL_REGISTER="true"
    BOOL_FETCH="true"
    COUNT=0
    while [ ${COUNT} -lt ${EUREKA_REPLICAS} ];
    do
        if [ $MY_POD_NAME != "$EUREKA_APPLICATION_NAME-$COUNT" ]; then
            temp="http://$EUREKA_APPLICATION_NAME-$COUNT.$MY_IN_SERVICE_NAME.$MY_POD_NAMESPACE.$postFix:8761/eureka/,"
            EUREKA_SERVER="$EUREKA_SERVER$temp"
            echo $EUREKA_SERVER
        fi
        let COUNT++
    done
fi

EUREKA_SERVER=${EUREKA_SERVER%?}
export EUREKA_SERVER
export BOOL_FETCH
export BOOL_REGISTER
echo "eureka url list : ${EUREKA_SERVER}"
echo "start eureka...."
java -jar /eureka-server.jar