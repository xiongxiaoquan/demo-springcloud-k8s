#!/bin/bash
postFix="svc.cluster.local"
EUREKA_HOST_NAME="$MY_POD_NAME.$MY_IN_SERVICE_NAME.$MY_POD_NAMESPACE.$postFix"
export EUREKA_HOST_NAME=$EUREKA_HOST_NAME
BOOL_REGISTER="true"
BOOL_FETCH="true"
if [ $EUREKA_REPLICAS = 1 ]; then
    echo "the replicas of eureka pod is one"
    BOOL_REGISTER="false"
    BOOL_FETCH="false"
    EUREKA_URL_LIST="http://$EUREKA_HOST_NAME:8761/eureka/,"
    echo " set the EUREKA_URL_LIST is $EUREKA_URL_LIST"
else
    echo "the replicas of the eureka pod is $EUREKA_REPLICAS"
    BOOL_REGISTER="true"
    BOOL_FETCH="true"
    COUNT=0
    while [ ${COUNT} -lt ${EUREKA_REPLICAS} ];
    do
        if [ $MY_POD_NAME != "$EUREKA_APPLICATION_NAME-$COUNT" ]; then
            temp="http://$EUREKA_APPLICATION_NAME-$COUNT.$MY_IN_SERVICE_NAME.$MY_POD_NAMESPACE.$postFix:8761/eureka/,"
            EUREKA_URL_LIST="$EUREKA_URL_LIST$temp"
            echo $EUREKA_URL_LIST
        fi
        let COUNT++
    done
fi

EUREKA_URL_LIST=${EUREKA_URL_LIST%?}
export EUREKA_URL_LIST
export BOOL_FETCH
export BOOL_REGISTER
echo "eureka url list : ${EUREKA_URL_LIST}"
echo "start eureka...."
java -jar /eureka-server.jar