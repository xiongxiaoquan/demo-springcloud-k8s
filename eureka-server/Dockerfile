FROM openjdk:8-jre-alpine
COPY target/eureka-server-0.0.1-SNAPSHOT.jar /eureka-server.jar
COPY dockerfiles/start.sh /start.sh
ENTRYPOINT ["sh","/start.sh"]