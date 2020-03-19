FROM maven:3.6.0-jdk-11-slim AS build

WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package

FROM openjdk:11-jdk
COPY --from=build /app/target/spring-boot-web.jar /
EXPOSE 8080
ENTRYPOINT ["java","-jar","/dfe-0.0.1-SNAPSHOT.jar"]