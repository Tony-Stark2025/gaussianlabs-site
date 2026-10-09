# Production container for Cloud Run deployment
FROM nginx:alpine

# Copy custom nginx configuration for Cloud Run $PORT support
COPY nginx.conf /etc/nginx/templates/default.conf.template

# Copy website assets
COPY index.html /usr/share/nginx/html/
COPY CNAME /usr/share/nginx/html/
COPY README.md /usr/share/nginx/html/
COPY assets/ /usr/share/nginx/html/assets/

ENV PORT=8080
EXPOSE 8080

CMD ["sh", "-c", "envsubst '${PORT}' < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
