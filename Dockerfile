FROM busybox AS builder

ARG dir="72656"
ARG name="pukiwiki-1.5.3_utf8"

RUN wget "http://iij.dl.osdn.jp/pukiwiki/${dir}/${name}.zip"
RUN unzip "${name}.zip"
RUN mv ${name} pukiwiki

WORKDIR /pukiwiki
RUN rm -f *.txt *.zip
RUN mkdir -p .orig/conf .orig/data
RUN for i in `find * -maxdepth 0 -name '*.ini.php'`; do mv $i .orig/conf/; ln -s /ext/conf/$i; done
RUN for i in `find * -maxdepth 0 -type d -perm 2777`; do mv $i .orig/data/; ln -s /ext/data/$i; done


FROM alpine:latest
LABEL maintainer "Abe Masahiro <pen@thcomp.org>"

RUN apk add --no-cache \
            h2o \
            perl \
            php7-cgi

COPY --from=builder /pukiwiki /var/www
COPY rootfs /

VOLUME /ext
EXPOSE 80

CMD ["/etc/rc.entry"]
