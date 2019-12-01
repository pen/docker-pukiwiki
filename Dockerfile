FROM busybox AS builder

ARG dir="69652"
ARG name="pukiwiki-1.5.2_utf8"

RUN wget "http://iij.dl.osdn.jp/pukiwiki/${dir}/${name}.zip"
RUN unzip "${name}.zip"
RUN mv ${name} pukiwiki

WORKDIR /pukiwiki
RUN mkdir -p .bak/conf .bak/data
RUN for i in `find * -maxdepth 0 -name '*.ini.php'`; do mv $i .bak/conf/; ln -s /ext/conf/$i; done
RUN for i in `find * -maxdepth 0 -type d -perm 2777`; do mv $i .bak/data/; ln -s /ext/data/$i; done


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
