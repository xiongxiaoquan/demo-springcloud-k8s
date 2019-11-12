FROM openjdk:8-jre-alpine
COPY target/springboot-provider-0.0.1-SNAPSHOT.jar /springboot-provider.jar
COPY dockerfiles/start.sh /start.sh
ENTRYPOINT ["sh","/start.sh"]