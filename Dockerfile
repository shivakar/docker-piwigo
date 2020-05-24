FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
    imagemagick \
    exiftool \
    ffmpeg \
    exiftran \
    poppler-utils \
    unzip \
    nginx \
    supervisor \
&& rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j4 mysqli && docker-php-ext-enable mysqli \
    && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini 

RUN cd /tmp \
    && curl -sLo piwigo.zip https://piwigo.org/download/dlcounter.php?code=2.10.2 \
    && unzip piwigo.zip \
    && mv piwigo/* /var/www/html/

COPY nginx.conf /etc/nginx/sites-enabled/default
COPY supervisord.conf /etc/supervisor/conf.d

EXPOSE 80
ENTRYPOINT ["/usr/bin/supervisord"]
