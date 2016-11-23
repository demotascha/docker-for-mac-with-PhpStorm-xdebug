FROM php:7.0-apache
MAINTAINER DemoHuang <demotascha@gmail.com>

# install requirements
ADD apt/source.list /etc/apt/source.list
RUN apt-get clean -y --force-yes && apt-get update -y --force-yes && apt-get install -y --force-yes \
        libmcrypt-dev \
        libicu-dev \
        zip unzip vim

RUN docker-php-ext-install -j$(nproc) mbstring mcrypt intl \
    && docker-php-ext-enable mbstring mcrypt intl

# copy server configs
ADD apache/default.conf /etc/apache2/sites-enabled/default.conf

COPY ./index.php /var/www/html/
# php storm command line debug
ENV PHP_IDE_CONFIG serverName=www.demo.local.tw
ENV XDEBUG_CONFIG idekey=PHPSTORM

# install php and other libraries
RUN pecl install -o -f xdebug
RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_host=10.254.254.254" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.max_nesting_level=512" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_log=/var/log/xdebug.log" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.profiler_enable=0" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.profiler_enable_trigger=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.coverage_enable=0" >> /usr/local/etc/php/conf.d/xdebug.ini

EXPOSE 80
CMD ["apache2-foreground"]
