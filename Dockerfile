FROM openjdk:17
COPY target/*.jar/
EXPOSE 8082
ENTRYPOINT ["java","-jar","/*.jar"]
