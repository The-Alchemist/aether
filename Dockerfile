# Use Node.js 18 LTS - provides good compatibility while being secure and supported
FROM node:18-alpine

# Install system dependencies including PhantomJS
RUN apk add --no-cache \
    git \
    && rm -rf /var/cache/apk/*

# Set working directory
WORKDIR /app

# Add node_modules/.bin to PATH for accessing local binaries
ENV PATH="/app/node_modules/.bin:$PATH"

# Copy package files
COPY package.json ./

# Install global dependencies required for building
RUN npm install grunt-cli jison

COPY Gruntfile.coffee ./
# Install dependencies
RUN npm install

# Copy source code
COPY bower.json ./
COPY rt.coffee ./
COPY sc.coffee ./
COPY src/ ./src/
COPY parsers/ ./parsers/

# Build the project (CoffeeScript will now be available)
RUN grunt build
