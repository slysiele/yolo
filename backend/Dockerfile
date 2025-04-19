# Set base image
FROM node:20-alpine3.21

# Set working directory
WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Install only production dependencies
RUN npm install --only=production && \
    npm cache clean --force && \
    rm -rf /tmp/*

# Copy application source
COPY . .

# Set environment
ENV NODE_ENV=production

# Expose backend port
EXPOSE 5000

# Start the application
CMD ["npm", "start"]
