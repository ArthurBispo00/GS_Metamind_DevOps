# Usar uma imagem base com JDK.
FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

RUN groupadd --system appgroup && useradd --system --gid appgroup appuser

# Copiar o arquivo JAR gerado pelo Maven.
COPY target/gsapi-0.0.1-SNAPSHOT.jar app.jar

RUN chown appuser:appgroup app.jar

USER appuser

# Variáveis de ambiente para a aplicação Spring Boot
ENV SPRING_DATASOURCE_URL=jdbc:oracle:thin:@oracle-db-container:1521/XEPDB1

# Defina o usuário que seu DDL criará
ENV SPRING_DATASOURCE_USERNAME=seu_usuario_oracle_app

# Defina a senha que seu DDL criará
ENV SPRING_DATASOURCE_PASSWORD=sua_senha_oracle_app

ENV SPRING_JPA_HIBERNATE_DDL_AUTO=validate

# Placeholder - Passe o valor real ao rodar o container
ENV Maps_APIKEY=""

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]