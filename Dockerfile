# Use Node.js base image
FROM node:18

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and install deps
COPY package*.json ./
RUN npm install

# Copy app source
COPY . .

# Expose app port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
