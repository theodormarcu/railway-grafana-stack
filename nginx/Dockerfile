FROM nginx:alpine

RUN apk add --no-cache apache2-utils

COPY nginx/nginx.conf.template /etc/nginx/nginx.conf.template
COPY nginx/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]