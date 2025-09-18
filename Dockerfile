ARG DEBIAN_RELEASE=bullseye
ARG LICENSE=''
FROM docker.io/debian:${DEBIAN_RELEASE}-slim

ARG DEBIAN_RELEASE
ARG TARGETARCH

COPY entrypoint.sh /
ENV DEBIAN_FRONTEND=noninteractive
ENV LICENSE=${LICENSE}

RUN apt update && \
    apt install -y gnupg ca-certificates curl socat && \
    curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ ${DEBIAN_RELEASE} main" \
      | tee /etc/apt/sources.list.d/cloudflare-client.list && \
    apt update && \
    apt install -y --no-install-recommends cloudflare-warp && \
    apt remove -y curl ca-certificates && \
    apt clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    chmod +x /entrypoint.sh

EXPOSE 40000/tcp
ENTRYPOINT ["/entrypoint.sh"]
