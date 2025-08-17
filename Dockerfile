FROM node:20

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

COPY rt.coffee ./
COPY sc.coffee ./
COPY src/ ./src/

# Build the project (CoffeeScript will now be available)
RUN grunt build
