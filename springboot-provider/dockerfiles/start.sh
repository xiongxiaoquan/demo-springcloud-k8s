#!/usr/bin/env bash
COUNT=0
while [ ${COUNT} -lt ${EUREKA_REPLICAS} ];
do
    temp="http://$EUREKA_APPLICATION_NAME-$COUNT.$POSTFIX,"
    EUREKA_SERVER="$EUREKA_SERVER$temp"
    let COUNT++
done

EUREKA_SERVER=${EUREKA_SERVER%?}
export EUREKA_SERVER
echo "eureka url list : ${EUREKA_SERVER}"
echo "start springboot-provider...."
java -jar /springboot-provider.jar