FROM amazoncorretto:21-alpine

ENV POSTGRES_PORT=5432

# Install node.js
RUN apk update && apk --no-cache add nodejs npm

WORKDIR /usr/app

# Install node modules
COPY package.json .
COPY package-lock.json .

RUN npm ci

# Build source
COPY . .

RUN npm run build

ENTRYPOINT ["./mvnw", "clean", "package", "cargo:run", "-Pglassfish"]