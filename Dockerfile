FROM alpine:3.14.0

LABEL org.opencontainers.image.source="https://github.com/ianatha/generate-changelog-action"

RUN apk --no-cache add --update git nodejs npm
RUN npm install -g generate-changelog

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
