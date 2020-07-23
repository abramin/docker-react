# Tag steps below as 'builder'
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build
# builder phase will output result of npm run build into /app/build

# Run phase - second FROM marks new block
FROM nginx
#copy to default nginx folder
COPY --from=builder /app/build /usr/share/nginx/html
# nginx container runs start by default