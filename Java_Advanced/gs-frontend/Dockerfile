# Estágio de Build
FROM node:20-alpine AS builder

WORKDIR /app

# MUDAR AQUI: Copiar package-lock.json em vez de yarn.lock
COPY package.json package-lock.json ./

# MUDAR AQUI: Usar npm install
RUN npm install --frozen-lockfile 

COPY . .

ENV NEXT_TELEMETRY_DISABLED=1

# MUDAR AQUI: Usar npm run build
RUN npm run build

# Estágio de Produção
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1 

RUN addgroup --system --gid 1001 nextjs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/next.config.ts ./next.config.ts

RUN chown -R nextjs:nextjs .
USER nextjs

EXPOSE 3000

# MUDAR AQUI: Usar npm start
CMD ["npm", "start"]