FROM php:7.2-apache

RUN								\
	apt-get update					&&	\
	apt-get install -y					\
		libfreetype6-dev				\
		libjpeg62-turbo-dev				\
		libpng-dev					\
		libmemcached-dev				\
		zlib1g-dev				&&	\
	docker-php-ext-install -j$(nproc) iconv 	&& 	\
	docker-php-ext-configure gd				\
		--with-freetype-dir=/usr/include/ 		\
		--with-jpeg-dir=/usr/include/		&& 	\
	docker-php-ext-install -j$(nproc) gd		&&	\
	docker-php-ext-install -j$(nproc) mysqli	&&	\
	pecl install memcached-2.2.0			&&	\
	docker-php-ext-enable memcached

# COPY ./php.ini /usr/local/etc/php/

EXPOSE 80
CMD ["apache2-foreground"]
