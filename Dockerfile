FROM alpine:3.21.3

LABEL maintainer="Ilnur Kiyamov <ilnurathome@gmail.com"
LABEL site.local.program.version="1.3.1"

ENV CONFIG_FILE=/app/etc/mqtt2elasticsearch.json \
    ELASTICSEARCH_MAPPING_FILE=/app/etc/mqtt2elasticsearch-mappings.json \
    REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

COPY --chown=root:root /src /

RUN apk upgrade --available --no-cache --update \
    && apk add --no-cache --update \
       python3 \
       py3-pip \
       ca-certificates \
    && pip3 install --no-cache-dir -r /requirements.txt --break-system-packages

USER 6352:6352

WORKDIR /app/bin

# Start Process
ENTRYPOINT ["python"]
CMD ["-u", "/app/bin/mqtt2elasticsearch.py"]
