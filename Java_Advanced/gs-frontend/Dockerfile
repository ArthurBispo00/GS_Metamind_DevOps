# Etapa 1: Build (Construção da Aplicação)
# Use uma imagem Node.js para construir a aplicação.
# Escolha uma versão do Node compatível com seu projeto (ex: 18, 20). Alpine é menor.
FROM node:18-alpine AS builder

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos de manifesto de dependências
# Copie package-lock.json, yarn.lock ou pnpm-lock.yaml se você os usar
COPY package.json ./
COPY package-lock.json ./
# Se usar yarn:
# COPY yarn.lock ./
# Se usar pnpm:
# COPY pnpm-lock.yaml ./

# Instala as dependências
# Se usar yarn: RUN yarn install --frozen-lockfile
# Se usar pnpm: RUN pnpm install --frozen-lockfile
RUN npm install

# Copia o restante do código da aplicação para o container
COPY . .

# Define a variável de ambiente para a URL da API do backend
# Este é um valor padrão/placeholder. Ele DEVE ser sobrescrito ao rodar o container.
ARG NEXT_PUBLIC_API_URL_ARG=http://localhost:8080/api
ENV NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL_ARG}

# Constrói a aplicação para produção
RUN npm run build

# Etapa 2: Runtime (Execução da Aplicação)
# Use uma imagem Node.js leve para rodar a aplicação construída.
FROM node:18-alpine

WORKDIR /app

# Crie um usuário não-root para rodar a aplicação (boa prática)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
# Se a imagem base não tiver addgroup/adduser, pode ser necessário
# USER node # Muitas imagens node já têm um usuário 'node'

# Copia apenas os artefatos necessários da etapa de build para a imagem final
# Isso inclui a pasta .next, public, package.json (para o script de start) e next.config.js
COPY --from=builder --chown=appuser:appgroup /app/.next ./.next
COPY --from=builder --chown=appuser:appgroup /app/public ./public
COPY --from=builder --chown=appuser:appgroup /app/package.json ./package.json
# Copie next.config.js ou next.config.mjs se existir
# COPY --from=builder --chown=appuser:appgroup /app/next.config.js ./next.config.js
COPY --from=builder --chown=appuser:appgroup /app/next.config.mjs ./next.config.mjs

# Define o usuário para rodar a aplicação
USER appuser

# Expõe a porta em que a aplicação Next.js roda (padrão 3000)
EXPOSE 3000

# Comando para iniciar a aplicação em modo de produção
# O package.json deve ter um script "start" como "next start"
CMD ["npm", "start"]