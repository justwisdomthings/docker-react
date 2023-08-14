FROM node:16-alpine as builder

WORKDIR '/app'

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build #puts build folder in /app/build


FROM nginx as runner

COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]