FROM amazoncorretto:21-alpine

ENV BEAUTEFLY_DB_HOST ""
ENV BEAUTEFLY_DB_PORT ""
ENV BEAUTEFLY_DB_NAME ""
ENV BEAUTEFLY_DB_USER ""
ENV BEAUTEFLY_DB_PASSWORD ""
ENV GLASSFISH_ADMIN_PASSWORD "admin"

# Install node.js
RUN apk update && apk --no-cache add nodejs npm curl

WORKDIR /usr/app

COPY .mvn ./.mvn
COPY mvnw .
COPY pom.xml .

RUN ./mvnw dependency:copy-dependencies cargo:configure

# Install node modules
COPY package.json .
COPY package-lock.json .

RUN npm ci

# Build source
COPY . .

RUN npm run build

ENTRYPOINT [ \
    "./mvnw", "package", "cargo:run", "-Pglassfish", \
    "-Dapp.dataSource.host=${BEAUTEFLY_DB_HOST}", \
    "-Dapp.dataSource.port=${BEAUTEFLY_DB_PORT}", \
    "-Dapp.dataSource.dbname=${BEAUTEFLY_DB_NAME}", \
    "-Dapp.dataSource.user=${BEAUTEFLY_DB_USER}", \
    "-Dapp.dataSource.password=${BEAUTEFLY_DB_PASSWORD}", \
    "-Dglassfish.adminPassword=${GLASSFISH_ADMIN_PASSWORD}" \
]

HEALTHCHECK --start-period=1m \
  CMD curl -f http://localhost:8080/ || exit 1