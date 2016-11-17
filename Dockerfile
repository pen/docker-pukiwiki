FROM alpine
MAINTAINER Abe Masahiro <pen@thcomp.org>

RUN apk add -q --no-cache \
            nginx \
            php5-fpm

RUN cd /var \
 && WIKI=pukiwiki-1.5.1_utf8 \
 && wget -q "http://jaist.dl.osdn.jp/pukiwiki/64807/$WIKI.zip" \
 && unzip -q $WIKI && rm $WIKI.zip \
 && rm -rf www && mv $WIKI www

COPY rootfs /

CMD ["/etc/rc.entry"]
