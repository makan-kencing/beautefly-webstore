FROM amazoncorretto:21-alpine

# Install node.js
RUN apk update && apk --no-cache add nodejs npm curl

WORKDIR /usr/app

COPY .mvn ./.mvn
COPY mvnw .
COPY pom.xml .

RUN ./mvnw dependency:resolve cargo:configure

# Install node modules
COPY package.json .
COPY package-lock.json .

RUN npm ci

# Build source
COPY . .

RUN npm run build

ENTRYPOINT [ \
    "./mvnw", "package", "cargo:run", "-Pglassfish", \
    "-Dapp.dataSource.jdbcUrl=${DATASOURCE_JDBC_URL}", \
    "-Dapp.dataSource.username=${DATASOURCE_USERNAME}", \
    "-Dapp.dataSource.password=${DATASOURCE_PASSWORD}", \
    "-Dglassfish.adminPassword=${GLASSFISH_ADMIN_PASSWORD}" \
]

HEALTHCHECK --start-period=1m \
  CMD curl -f http://localhost:8080/ || exit 1