FROM --platform=$BUILDPLATFORM alpine:latest AS build

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=0.3.0

COPY .build/vault-k8s* /
RUN mv /vault-k8s_linux_${TARGETPLATFORM##linux/}* /vault-k8s

FROM alpine:latest

RUN addgroup vault && \
  adduser -S -G vault vault

COPY --chown=vault:vault --from=build /vault-k8s /vault-k8s

USER vault

ENTRYPOINT ["/vault-k8s"]
