FROM alpine:latest as compiler

RUN apk add --update git build-base autoconf automake libtool curl
RUN rm -rf /tmp/protobuf && mkdir /tmp/protobuf
RUN cd /tmp/ && git clone https://github.com/google/protobuf -b v3.5.1.1
RUN cd /tmp/protobuf && ./autogen.sh
RUN cd /tmp/protobuf && ./configure
RUN cd /tmp/protobuf && make
RUN cd /tmp/protobuf && make install
RUN apk del git build-base autoconf automake libtool curl
RUN rm -rf /tmp/*
RUN apk add libstdc++
RUN mkdir -p /tmp/src
WORKDIR /tmp/src

ENTRYPOINT [ "protoc" ]