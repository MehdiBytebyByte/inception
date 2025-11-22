FROM debian:bookworm

# 1. Install NGINX and OpenSSL
RUN apt-get update && apt-get install -y \
    nginx \
    openssl && \
    rm -rf /var/lib/apt/lists/*

# 2. Generate SSL Certificate
# (I added your Khouribga location details here)
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=MA/ST=BeniMellal/L=Khouribga/O=42/OU=42/CN=mboughra.42.fr/UID=mboughra"

# 3. Copy Config
# Ensure your config is at srcs/requirements/nginx/conf/nginx.conf
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# 4. Setup folders
RUN mkdir -p /var/run/nginx
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# 5. Start
CMD ["nginx", "-g", "daemon off;"]