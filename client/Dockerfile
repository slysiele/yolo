# Build stage
FROM node:20-alpine3.21 as build

WORKDIR /app

# Set legacy OpenSSL mode to avoid Webpack error
ENV NODE_OPTIONS=--openssl-legacy-provider

COPY package*.json ./
RUN npm install && npm cache clean --force && rm -rf /tmp/*

COPY . .
RUN npm run build

# Production stage with Nginx
FROM nginx:stable-alpine as production

# Copy built files to nginx public folder
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom nginx config if needed (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
