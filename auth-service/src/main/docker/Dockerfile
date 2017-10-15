FROM openjdk:9-jre-slim
VOLUME /tmp
ADD target/auth-service-0.0.1.jar app.jar
ENV JAVA_OPTS=""
RUN useradd --create-home -s /bin/bash user
WORKDIR /home/user
USER user
EXPOSE 8080
ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar
