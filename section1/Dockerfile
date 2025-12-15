FROM node:20-alpine AS backend_builder

WORKDIR /app

COPY . .

RUN npm install --production

FROM node:20-alpine 

RUN addgroup -S nodegroup && adduser -S -G nodegroup nodeuser

USER nodeuser

WORKDIR /app

COPY --from=backend_builder /app /app

EXPOSE 3000

CMD ["node", "app.js"]

