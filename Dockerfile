FROM alpine:latest AS build

ARG UPSTREAM_VERSION
ARG ARCH=linux_amd64

WORKDIR /root

RUN wget https://github.com/fatedier/frp/releases/download/${UPSTREAM_VERSION}/frp_${UPSTREAM_VERSION#v}_${ARCH}.tar.gz -O frp.tar.gz

RUN tar -xzvf frp.tar.gz && mv frp_${UPSTREAM_VERSION#v}_${ARCH}/frpc .

FROM scratch

WORKDIR /

COPY --from=build /root/frpc /

ENTRYPOINT ["/frpc"]
