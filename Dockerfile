FROM --platform=$BUILDPLATFORM alpine:latest AS build

ARG TARGETARCH
ARG UPSTREAM_VERSION

WORKDIR /root

RUN ARCH="linux_${TARGETARCH}" && \
    wget https://github.com/fatedier/frp/releases/download/${UPSTREAM_VERSION}/frp_${UPSTREAM_VERSION#v}_${ARCH}.tar.gz -O frp.tar.gz && \
	tar -xzvf frp.tar.gz && \
	mv frp_${UPSTREAM_VERSION#v}_${ARCH}/frpc .

FROM scratch

WORKDIR /

COPY --from=build /root/frpc /

ENTRYPOINT ["/frpc"]
