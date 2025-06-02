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