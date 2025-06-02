# Usar uma imagem oficial do Oracle Database Express Edition (XE)
# Esta é uma versão gratuita, boa para desenvolvimento e projetos menores.
FROM container-registry.oracle.com/database/express:21.3.0-xe

# Variável de ambiente para a senha do SYS, SYSTEM, PDBADMIN (obrigatória pela imagem base Oracle)
# Esta senha é para administração do banco, não para o usuário da sua aplicação.
# Para o trabalho, defina uma aqui para demonstrar o uso da ENV.
ENV ORACLE_PWD=MinhaSenhaOracleAdminSegura123

# Definir um diretório de trabalho (opcional para Oracle, mas um requisito do trabalho)
WORKDIR /opt/oracle/scripts

# Copiar seu script DDL customizado para o diretório de inicialização do Oracle.
# Scripts .sql ou .sh neste diretório (/opt/oracle/scripts/startup/)
# são executados automaticamente quando o banco é configurado pela primeira vez.
# Certifique-se que o nome 'setup_oracle_gs.sql' aqui corresponde ao nome do seu arquivo DDL.
COPY setup_oracle_gs.sql /opt/oracle/scripts/startup/01_setup_app_user_schema.sql

# A imagem base do Oracle XE já configura e roda o banco com um usuário 'oracle' do SO,
# que não é root, satisfazendo o requisito de usuário não-root para o processo do banco.
# O ENTRYPOINT e CMD são herdados da imagem base para iniciar o Oracle corretamente.

# Expor a porta padrão do Oracle Listener
EXPOSE 1521