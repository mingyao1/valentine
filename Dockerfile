# Build stage
FROM node:20-alpine AS build
WORKDIR /app
COPY app/package.json app/package-lock.json* ./
RUN npm install
COPY app/ .
RUN npm run build

# Production stage – serve with nginx
FROM nginx:alpine
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/valentine.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
