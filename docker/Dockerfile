FROM eclipse-temurin:17-jdk-jammy AS build
SHELL ["/bin/bash", "--login", "-i", "-c"]

# Install Node.js
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
RUN . $HOME/.nvm/nvm.sh
RUN nvm install 22

WORKDIR /usr/app

# Install maven dependencies
COPY .mvn ./.mvn
COPY mvnw mvnw
COPY pom.xml pom.xml
RUN ./mvnw dependency:copy-dependencies

# Install Node.js dependencies
COPY package.json .
COPY package-lock.json .
RUN npm ci

COPY . .

# Compile
RUN npm run build
RUN --mount=type=cache,target=/root/.m2 ./mvnw clean package

FROM ghcr.io/eclipse-ee4j/glassfish

COPY --from=build-env /usr/app/target/*.war /opt/glassfish7/glassfish/domains/domain1/autodeploy/web.war

HEALTHCHECK --start-period=1m \
  CMD curl -f http://localhost:8080/api/ping || exit 1
