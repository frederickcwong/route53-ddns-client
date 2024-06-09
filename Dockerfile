FROM alpine:latest
ARG VERSION

COPY ./route53-ddns /route53-ddns

RUN apk -U upgrade \
    && apk add -U bash bind-tools curl jq

RUN echo "VERSION=$VERSION" >> /version.txt
RUN echo "ALPINE_VERSION=`cat /etc/os-release | grep VERSION_ID | awk -F= '{print $2}'`" >> /version.txt

CMD ["/route53-ddns/cmd.sh"]
