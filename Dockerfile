FROM openjdk:17
COPY target/achat-${BUILD_VERSION}.jar /app/achat-${BUILD_VERSION}.jar
EXPOSE 8082
ENTRYPOINT ["java", "-jar", "/app/achat-${BUILD_VERSION}.jar"]
