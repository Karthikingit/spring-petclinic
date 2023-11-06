FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
VOLUME /opt/app
COPY /target/MavenBuildArtifacts/spring-petclinic-3.1.0-SNAPSHOT.jar /app/petclinic.jar
EXPOSE 8080
CMD ["java","-jar","/app/petclinic.jar"]