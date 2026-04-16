FROM eclipse-temurin:8-jre
WORKDIR /app
COPY target/*.jar app.jar
ENTRYPOINT ["java","-cp","app.jar","com.example.App"]