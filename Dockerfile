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

# HACK: fix old version of jasmine-node which uses this.print_ and util.print instead of console.log
RUN grep --include='*.js' -rl "this\.print_(" node_modules | xargs sed -i 's/this\.print_(/console.log(/g'
RUN grep --include='*.js' -rl "util\.print("  node_modules | xargs sed -i 's/util\.print(/console.log(/g'

# Copy source code

COPY rt.coffee ./
COPY sc.coffee ./
COPY src/ ./src/
COPY parsers/ ./parsers/

# Build the project (CoffeeScript will now be available)
RUN grunt build
