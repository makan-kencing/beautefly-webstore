FROM eclipse-temurin:17-jdk-jammy AS build

SHELL ["/bin/bash", "--login", "-i", "-c"]

# Install node.js
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
RUN . $HOME/.nvm/nvm.sh
RUN nvm install 22

WORKDIR /usr/app

# Install node modules
COPY package.json .
COPY package-lock.json .

RUN npm ci

# Build source
COPY . .

#RUN npm run dev

RUN --mount=type=cache,target=/root/.m2 ./mvnw -f pom.xml clean package

FROM ghcr.io/eclipse-ee4j/glassfish

COPY --from=build /usr/app/target/*.war /opt/glassfish7/glassfish/domains/domain1/autodeploy/web.war