FROM node:20-alpine

WORKDIR /app

COPY . .

EXPOSE 3000

RUN npm install

# Start the application in development mode with npm run start:dev
CMD ["npm", "run", "start:dev"]
