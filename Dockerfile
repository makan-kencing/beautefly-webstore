FROM eclipse-temurin:17-jdk-jammy AS build

WORKDIR /usr/app

ADD . /usr/app

RUN --mount=type=cache,target=/root/.m2 ./mvnw -f pom.xml clean package

FROM ghcr.io/eclipse-ee4j/glassfish

COPY --from=build /usr/app/target/*.war /opt/glassfish7/glassfish/domains/domain1/autodeploy/web.war