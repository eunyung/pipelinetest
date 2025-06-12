FROM maven:3.8.3-openjdk-17 AS build
ARG BUILD_ENV
COPY src /home/app/src
COPY libs /home/app/libs
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:17-alpine
COPY libs /home/app/libs
COPY --from=build /home/app/target/hellospring-0.0.1-SNAPSHOT.jar /usr/local/lib/hellospring.jar
EXPOSE 80
ENTRYPOINT ["java","-jar", "/usr/local/lib/hellospring.jar"]
