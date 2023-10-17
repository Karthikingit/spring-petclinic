FROM maven:3.8.1-openjdk-17-slim

COPY . .

RUN mvn package -Dmaven.test.skip=true