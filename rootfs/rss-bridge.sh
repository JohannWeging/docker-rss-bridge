#!/bin/sh

php-fpm7
nginx -c /etc/nginx/nginx.conf

while true; do
    sleep 10
    for PROC in "nginx" "php-fpm"; do
        pkill -0 -f "${PROC}"
        sleep 1
    done
done

