FROM johannweging/base-alpine:latest

ENV RSS_BRIDGE_VERSION=${RSS_BRIDGE_VERSION}

RUN set -x \
&& apk add --update --no-cache nginx php7-fpm php7-openssl php7-mbstring php7-simplexml php7-curl

RUN set -x \
&& apk add --no-cache --virtual .dep git \
&& mkdir -p /var/www \
&& cd /var/www \
&& git clone https://github.com/RSS-Bridge/rss-bridge.git \
&& cd rss-bridge \
&& git checkout ${RSS_BRIDGE_VERSION} \
&& echo "*" > whitelist.txt \
&& rm -rf .git \
&& mkdir -p chache \
&& chown nginx:www-data cache \
&& chmod 777 cache \
&& cd / \
&& apk del .dep

ADD rootfs /

RUN set -x \
&& chmod +x /rss-bridge.sh \
&& chown nginx:www-data -R /var/www 

EXPOSE 80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/rss-bridge.sh"]
