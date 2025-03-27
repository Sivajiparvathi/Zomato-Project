FROM node:18-slim AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Production
FROM builder AS final
WORKDIR /app
COPY --from=builder /app/build ./build
COPY package*.json ./
RUN npm install --production
EXPOSE 3000
CMD ["npm", "start"]
