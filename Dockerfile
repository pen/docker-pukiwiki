FROM busybox:1.36 AS builder

ARG tag="r1_5_4"

RUN wget "https://github.com/pukiwiki/pukiwiki/archive/refs/tags/$tag.zip"
RUN unzip "$tag.zip"
RUN mv "pukiwiki-$tag" pukiwiki

WORKDIR /pukiwiki
RUN rm -f *.txt *.zip
RUN mkdir -p .orig/conf .orig/data
RUN for i in `find * -maxdepth 0 -name '*.ini.php'`; do mv $i .orig/conf/; ln -s /ext/conf/$i; done
RUN for i in `find * -maxdepth 0 -type d -perm 2777`; do mv $i .orig/data/; ln -s /ext/data/$i; done


FROM alpine:3.18
LABEL org.opencontainers.image.authors="Abe Masahiro <pen@thcomp.org>" \
    org.opencontainers.image.source="https://github.com/pen/docker-pukiwiki"

RUN apk add --no-cache \
            h2o \
            perl \
            php-cgi

COPY --from=builder /pukiwiki /var/www
COPY rootfs /

VOLUME /ext
EXPOSE 80

CMD ["/etc/rc.entry"]
