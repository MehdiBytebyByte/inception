FROM debian:bookworm

# 1. Install PHP, wget AND ca-certificates
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    wget \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# 2. Configure PHP to listen on port 9000
RUN sed -i 's,listen = /run/php/php8.2-fpm.sock,listen = 9000,' /etc/php/8.2/fpm/pool.d/www.conf

# 3. Create the folder for the PID file
RUN mkdir -p /run/php

# 4. Copy the script
# Ensure your script is at srcs/requirements/wordpress/tools/script.sh
COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

# 5. Set work directory
WORKDIR /var/www/html

# 6. Launch
CMD ["/usr/local/bin/script.sh"]