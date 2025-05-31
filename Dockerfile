# Stage 1: Use a Node.js LTS (Long Term Support) image for building
FROM node:20-alpine As builder

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install --only=production

COPY . .

# Stage 2: Create a smaller production image
FROM node:20-alpine

WORKDIR /usr/src/app

# Copy only necessary files from the builder stage
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/server.js ./server.js

# Environment variable for the app port
ENV PORT=3000
EXPOSE 3000

# Environment variable for app version (will be set during Docker build or run)
ENV APP_VERSION="1.0.0"

CMD ["node", "server.js"]