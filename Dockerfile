FROM cirrusci/flutter as build
WORKDIR /usr/src
COPY . .
RUN flutter build web
FROM nginx:alpine
COPY --from=build /usr/src/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /usr/src/build/web /usr/share/nginx/html