# 🌍 Alerta de Eventos Extremos - Global Solution FIAP (GS_FIAP_2025_1SM)

Este repositório contém a solução para a Global Solution FIAP, um sistema de cadastro de usuários que visa alertá-los sobre eventos climáticos extremos em suas localidades, utilizando dados em tempo real. A solução é composta por um backend Java (Spring Boot), um frontend Next.js e um banco de dados Oracle, todos containerizados com Docker.

---

## 📜 Funcionalidades Principais

* **Cadastro de Usuários:** Permite o registro de usuários com informações pessoais e de localização.
* **Consulta de Localização:** Utiliza a localização do usuário para monitoramento.
* **Integração com API de Eventos Climáticos (EONET):** Busca e processa dados sobre desastres naturais.
* **Sistema de Alertas:** Notifica os usuários sobre perigos iminentes em suas áreas registradas.
* **Visualização de Dados:** O frontend exibe informações relevantes, mapas e permite a interação do usuário com o sistema.

---

## 🛠️ Tecnologias Utilizadas

* **Backend:** Java 17+, Spring Boot 3+
* **Frontend:** Next.js 13+, React, TypeScript
* **Banco de Dados:** Oracle Database Express Edition (XE) 21c (Containerizado)
* **API Externa:** NASA EONET (Events and Observations Network)
* **Geocodificação/Mapas:** ViaCEP, Google Maps API (ou similar)
* **Containerização:** Docker
* **Build Tools:** Maven (para Java), npm/yarn (para Next.js)

---

## 📂 Estrutura do Projeto

O projeto está organizado nas seguintes pastas principais na raiz do repositório:

* `Java_Advanced/gsapi/`: Contém o código-fonte do backend Java Spring Boot e seu `Dockerfile`.
* `oracle-db-docker/`: Contém o `Dockerfile` para a imagem personalizada do Oracle DB e o script DDL (`setup_oracle_gs.sql`) para criação do schema.
* `frontend-gs-alertas/` (ou `gs-frontend/`): Contém o código-fonte do frontend Next.js e seu `Dockerfile`.

---

## ✅ Pré-requisitos (para ambiente local)

* [Git](https://git-scm.com/downloads)
* [Docker Desktop](https://www.docker.com/products/docker-desktop/) ou Docker Engine/CLI para Linux.
* [Java Development Kit (JDK)](https://www.oracle.com/java/technologies/downloads/) - Versão 17 ou superior (para compilar o backend localmente, se necessário, ou se não for usar apenas o build Docker).
* [Node.js e npm/yarn](https://nodejs.org/) - Versão LTS (para o frontend, se for rodar localmente fora do Docker ou para a etapa de build do Docker do frontend).
* [Maven](https://maven.apache.org/download.cgi) (geralmente já vem com IDEs como IntelliJ IDEA, ou pode ser instalado separadamente).

---

## 🚀 Configuração e Execução Local com Docker

Siga os passos abaixo para configurar e executar a aplicação completa utilizando Docker na sua máquina local.

### 1. Clonar o Repositório

```bash
git clone https://github.com/ArthurBispo00/GS_Metamind_DevOps
cd NOME_DO_SEU_REPOSITORIO
```

### 2. Construir imagens docker 

#### 1. Construir a Imagem da Aplicação Java:

Abra seu terminal ou prompt de comando.

Navegue no terminal até a pasta onde está o `Dockerfile` da sua aplicação Java (ex: `GS_FIAP_2025_1SM-1/Java_Advanced/gsapi/`).

```bash
cd caminho/para/GS_FIAP_2025_1SM-1/Java_Advanced/gsapi
```
Execute o comando de build:

```bash
docker build -t gs-app-backend:latest .
```

#### 2. Construir a Imagem do Banco de Dados Oracle:

Navegue no terminal até a pasta que contém o `Dockerfile` do seu Oracle e o script DDL (ex: `GS_FIAP_2025_1SM-1/oracle-db-docker/`).

Navegue para a pasta `oracle-db-docker/`.

```bash
cd caminho/para/GS_FIAP_2025_1SM-1/oracle-db-docker
```

Execute o build:

```bash
docker build -t gs-oracle-db:custom .
```

Nota: A construção desta imagem, especialmente na primeira vez, pode demorar bastante (10-20 minutos ou mais) devido ao download da imagem base do Oracle Database Express Edition. Tenha paciência e aguarde a conclusão.


#### 3. Construir a Imagem do Front-End:

Navegue no terminal até a pasta que contém o `Dockerfile` do seu Oracle e o script DDL (ex: `GS_FIAP_2025_1SM-1/Java_Advanced/gs-frontend`).

Navegue para a pasta `gs-frontend/`.

```bash
cd caminho/para/GS_FIAP_2025_1SM-1/Java_Advanced/gs-frontend
```

Carregue a imagem Docker localmente:

```bash
docker load -i minha-app-next.tar
```

Em seguida, construa a imagem Docker do front-end:

```bash
docker build -t gs-app-frontend:latest .
```

## 🚀 Executar a Aplicação com Docker (Backend ,Banco de Dados e Front-End)

Siga os passos abaixo para executar os containers do backend, do banco de dados e do Front-End.

### 1. Criar uma Rede Docker Customizada

Para que os containers possam se comunicar usando nomes de host, criaremos uma rede Docker.

```bash
docker network create gs-fiap-network
```
Se você já executou `docker network create gs-fiap-network`, agora execute:

```bash
docker network ls
```

Procure pela rede `gs-fiap-network` na lista

### 2. Criar um Volume Docker para Persistência do Oracle

Para garantir que os dados do seu banco de dados Oracle não sejam perdidos caso o container seja parado, removido ou recriado, vamos criar um "volume nomeado" no Docker. Este volume armazenará os arquivos de dados do Oracle de forma independente do ciclo de vida do container.

Adicione a seção "Criar um Volume Docker para Persistência do Oracle" ao seu `README.md`.
Execute o comando no seu terminal:
    
```bash
docker volume create oracle_gs_data
```

Em seguida, verifique com:

```bash
docker volume ls
```

### 3. Executar o Container do Banco de Dados Oracle

Este comando iniciará o container do Oracle em segundo plano (`-d`), conectado à rede que criamos, com a porta mapeada e o volume montado. Lembre-se que a senha administrativa (`ORACLE_PWD`) no Dockerfile do Oracle foi definida como `senhaoracle`. O usuário da sua aplicação (que você definiu no script DDL, por exemplo, `global` com senha `paulo1`) será criado automaticamente quando o Oracle executar o script DDL durante a primeira inicialização.

Execute o comando:

```bash
docker run -d --name oracle-db-container --network gs-fiap-network -p 1521:1521 -e ORACLE_PWD=senhaoracle -v oracle_gs_data:/opt/oracle/oradata gs-oracle-db:custom
```
Importante: Aguarde a Inicialização do Oracle!

Após executar o comando docker run acima, o Oracle Database precisa de alguns minutos (geralmente de 2 a 5 minutos, mas pode ser mais dependendo da sua máquina) para:

1. Inicializar pela primeira vez.
2. Criar a estrutura do banco de dados.
3. Executar o seu script DDL customizado (o setup_oracle_gs.sql que foi colocado na imagem) para criar seu usuário (global) e todas as suas tabelas.

**Como verificar o progresso e se está pronto:**
Para verificar se o container está em execução, use:

```bash
docker ps
```

dê o comando:

```bash
docker logs -f oracle-db-container
```
para verificar os logs e as criação das tabelas.

### 4. Executar o Container do Backend Java

Com o container do Oracle (`oracle-db-container`) em execução e devidamente inicializado, podemos iniciar o container da aplicação Java Spring Boot. Este container se conectará ao Oracle através da rede `gs-fiap-network`.

Execute o comando abaixo. Lembre-se de:
* Substituir `"SUA_Maps_API_KEY_REAL"` pela sua chave real da API do Google Maps. Se você não for usar essa funcionalidade agora ou não tiver uma chave, pode deixar a string vazia `""` ou remover a linha `-e Maps_APIKEY=...` por enquanto.
* Certificar-se de que `SPRING_DATASOURCE_USERNAME` (ex: `global`) e `SPRING_DATASOURCE_PASSWORD` (ex: `paulo1`) correspondem ao usuário e senha que você criou no seu script DDL dentro do container Oracle.

```bash
 docker run -d --name backend-api-container --network gs-fiap-network -p 8080:8080 -e SPRING_DATASOURCE_URL=jdbc:oracle:thin:@oracle-db-container:1521:XE -e SPRING_DATASOURCE_USERNAME=global -e SPRING_DATASOURCE_PASSWORD=paulo1 -e SPRING_JPA_HIBERNATE_DDL_AUTO=validate -e Maps_APIKEY=AIzaSyBc94e1VSiZ3cIoASH2Ko8RryGlNBhltJM gs-app-backend:latest
```
**Como verificar o progresso e se está pronto:**
Para verificar se o container está em execução, use:

```bash
docker ps
```

dê o comando:

```bash
docker logs -f backend-api-container
```
para verificar os logs e as criação das tabelas.

### 5. Executar o Container do Front-End

Com o container do Oracle (oracle-db-container) em execução e devidamente inicializado, podemos iniciar o container do front-end (ex: uma aplicação Next.js). Este container se conectará ao banco Oracle através da rede Docker gs-fiap-network.

Execute o comando abaixo. Atenção aos seguintes pontos:

```bash
docker run -d --name frontend-api-container --network gs-fiap-network -p 3000:3000 gs-app-frontend:latest
```
**Como verificar o progresso e se está pronto:**
Para verificar se o container está em execução, use:

```bash
docker ps
```

dê o comando:

```bash
docker logs -f frontend-api-container
```
para verificar os logs e as criação das tabelas.

### 6.Exempo de Cadastro no Site

## Detalhes Pessoais

* **ARTHUR BISPO DE LIMA**
* **🎂 Data de Nascimento:** 06/03/2000
* **📄 Documento:** 41204141805

---

## Contato Principal

* **📞 Contato Principal:**
    * **📧 Email:** arthurbiapo@hotmail.com
    * **☎️ Telefone:** (11) 99145-6219
    * **📱 Celular:** (11) 99145-6219
    * **💬 WhatsApp:** (11) 99145-6219
    * **🏷️ Tipo:** Principal

---

## Endereço Principal

* **🏠 Endereço Principal:**
    * Rua Floriano Peixoto, 460 - Casa
    * Vila Romanópolis - Ferraz de Vasconcelos/SP
    * CEP: 08529-030
* **🌐 Coordenadas:**
    * **Latitude (Lat):** -14.2350040
    * **Longitude (Lon):** -51.9252800