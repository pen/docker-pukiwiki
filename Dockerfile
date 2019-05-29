FROM alpine
MAINTAINER Abe Masahiro <pen@thcomp.org>

RUN apk add -U --virtual .builders \
            curl

RUN apk add \
            h2o \
            perl \
            php7-cgi

COPY rootfs /

RUN cd /var \
 && WIKI=pukiwiki-1.5.2_utf8 \
 && curl -O "http://iij.dl.osdn.jp/pukiwiki/69652/$WIKI.zip" \
 && unzip -q $WIKI && rm $WIKI.zip \
 && rm -rf www && mv $WIKI www \
 && cd www \
 && mkdir -p .bak/conf .bak/data \
 && for i in `find * -maxdepth 0 -name '*.ini.php'`; do mv $i .bak/conf/; ln -s /ext/conf/$i; done \
 && for i in `find * -maxdepth 0 -type d -perm 2777`; do mv $i .bak/data/; ln -s /ext/data/$i; done

RUN apk del .builders \
 && rm -rf /var/cache/apk

VOLUME /ext
EXPOSE 80

CMD ["/etc/rc.entry"]
