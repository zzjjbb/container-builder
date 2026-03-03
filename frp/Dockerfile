# download binaries
FROM --platform=$BUILDPLATFORM alpine:latest AS build

ARG TARGETARCH
ARG UPSTREAM_VERSION

WORKDIR /root

RUN ARCH="linux_${TARGETARCH}" && \
    TAR_NAME="frp_${UPSTREAM_VERSION#v}_${ARCH}.tar.gz" && \
    wget https://github.com/fatedier/frp/releases/download/${UPSTREAM_VERSION}/${TAR_NAME} && \
	tar -xzvf $TAR_NAME && \
	rm $TAR_NAME && \
	mv frp_${UPSTREAM_VERSION#v}_${ARCH}/* .


# frpc
FROM scratch AS frpc

WORKDIR /

COPY --from=build /root/frpc /

ENTRYPOINT ["/frpc"]


# frps
FROM scratch AS frps

WORKDIR /

COPY --from=build /root/frps /

ENTRYPOINT ["/frps"]

