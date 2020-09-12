FROM ubuntu:18.04
#VOLUME /var/lib/mysql

RUN echo 'start build' \
# if you are not in China,delete the following two lines
    && sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && apt update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt --no-install-recommends install nginx mysql-server mysql-client php7.2 php7.2-fpm php7.2-mysql -y \
    && apt --no-install-recommends install php7.2-fpm php7.2-mysql php7.2-curl php7.2-gd php7.2-mbstring php7.2-xml php7.2-xmlrpc php7.2-zip php7.2-opcache php7.2-ldap php7.2-json php7.2-redis php7.2-memcached -y \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && sed -i 's/index index.html index.htm index.nginx-debian.html;/index index.php index.html index.htm index.nginx-debian.html;/g' /etc/nginx/sites-available/default \
    && sed -i '/location ~ \\.php$ {/s/#//' /etc/nginx/sites-available/default \
    && sed -i '/include snippets\/fastcgi-php.conf;/s/#//' /etc/nginx/sites-available/default \
    && sed -i '/fastcgi_pass 127.0.0.1:9000/s/#//' /etc/nginx/sites-available/default \
    && sed -i '/fastcgi_pass 127.0.0.1:9000/{n;s/#//;}' /etc/nginx/sites-available/default \
    && sed -i 's/listen = \/run\/php\/php7.2-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/7.2/fpm/pool.d/www.conf \
    && touch /var/www/html/info.php \
    && echo "<?php phpinfo() ?>">>/var/www/html/info.php \
    && service nginx start || service nginx restart && service php7.2-fpm start || service php7.2-fpm restart && service mysql start || service mysql restart \
    && apt clean \
    && apt autoclean \
    && apt autoremove -y

CMD service nginx start || service nginx restart && service php7.2-fpm start || service php7.2-fpm restart && service mysql start || service mysql restart && tail -f /var/log/wtmp
