FROM alpine

RUN apk --no-cache add bash

VOLUME /shared /script

WORKDIR /script

ENTRYPOINT /bin/bash ./script.sh