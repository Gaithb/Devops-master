FROM openjdk:17
EXPOSE 8082
ADD target/achat-1.9.jar achat-1.9.jar
ENTRYPOINT ["java","-jar","/*.jar"]
