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

RUN cd /var/www \
 && mkdir -p .bak/conf .bak/data \
 && for i in `find * -maxdepth 0 -name '*.ini.php'`; do mv $i .bak/conf/; ln -s /ext/conf/$i; done \
 && for i in `find * -maxdepth 0 -type d -perm 777`; do mv $i .bak/data/; ln -s /ext/data/$i; done

COPY ["rootfs", "/"]

VOLUME ["/ext"]
EXPOSE 80

CMD ["/etc/rc.entry"]
