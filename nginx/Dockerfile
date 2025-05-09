FROM nginx:alpine

RUN apk add --no-cache apache2-utils

COPY nginx/nginx_template.conf /etc/nginx/nginx_template.conf
COPY nginx/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]