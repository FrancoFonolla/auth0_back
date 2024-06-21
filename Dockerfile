# Etapa de construcción
FROM openjdk:17-alpine as build

# Actualizamos y añadimos Gradle y bash
RUN apk update && apk add --no-cache bash

# Establecemos el directorio de trabajo
WORKDIR /app

# Copiamos los archivos del proyecto
COPY . .

# Damos permisos de ejecución al script de Gradle
RUN chmod +x ./gradlew

# Construimos el jar de la aplicación
RUN ./gradlew bootJar --no-daemon

# Etapa final
FROM openjdk:17-alpine

# Exponemos el puerto 8080
EXPOSE 8080

# Copiamos el jar construido en la etapa anterior
COPY --from=build /app/build/libs/*.jar /app/app.jar



# Definimos el comando para correr la aplicación
ENTRYPOINT ["java", "-jar", "/app/app.jar"]