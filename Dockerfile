#Etapa de compilacion o construccion 
FROM node:16 AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

#Etapa de produccion

FROM nginx:latest AS production-stage
COPY --from=build-stage /app/dist usr/share/nginx/http
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


