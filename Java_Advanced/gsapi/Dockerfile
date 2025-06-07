FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

RUN groupadd --system appgroup && useradd --system --gid appgroup appuser

COPY target/gsapi-0.0.1-SNAPSHOT.jar app.jar

RUN chown appuser:appgroup app.jar

USER appuser

# ATENÇÃO: Corrigir a URL do banco de dados para usar o SID 'XE'
ENV SPRING_DATASOURCE_URL=jdbc:oracle:thin:@oracle-db-container:1521:XE

# ATENÇÃO: Usar suas credenciais reais aqui (global e paulo1)
ENV SPRING_DATASOURCE_USERNAME=global
ENV SPRING_DATASOURCE_PASSWORD=paulo1

ENV SPRING_JPA_HIBERNATE_DDL_AUTO=validate
ENV Maps_APIKEY="" 

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]