FROM alpine

RUN apk --no-cache add bash

VOLUME ./shared

WORKDIR /

COPY ./script.sh ./

ENTRYPOINT /bin/bash ./script.sh