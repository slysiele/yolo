# Setting the base image
FROM node:20-alpine3.21

# Setting the working directory in the container
WORKDIR /backend

# Copy only the package files to install dependencies first
COPY package*.json ./

# Install only production dependencies
RUN npm install --only=production && \
    npm cache clean --force && \
    rm -rf /tmp/*

# Copy the rest of the application source code
COPY . .

# Set environment variable for production
ENV NODE_ENV=production

# Expose the backend port
EXPOSE 5000

# Remove dev dependencies (if any remain), clean cache again, and delete temp files
RUN npm prune --production && \
    npm cache clean --force && \
    rm -rf /tmp/*

# Start the backend server
CMD ["npm", "start"]
