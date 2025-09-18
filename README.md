# docker-warp-proxy

Docker image to run Cloudflare Warp in proxy mode. Image is rebuilt and updated every day.

## Usage

```
docker run -d -p 40000:40000 --restart unless-stopped ghcr.io/rxflex/cloudflare-warp-proxy
```

SOCKS5 proxy server will be listening at port 40000.

### docker-compose

```yml
version: "3.0"

services:
  cloudflare-warp-proxy:
    image: ghcr.io/rxflex/cloudflare-warp-proxy
    network_mode: bridge
    ports:
      - 40000:40000
    restart: unless-stopped
    environment:
    # use your own wrap+ key
      - LICENSE=''
    logging:
      driver: json-file
      options:
        max-size: 1m

```

## test

```bash
curl https://www.cloudflare.com/cdn-cgi/trace/ -x socks5h://127.1:40000  # remote dns mode

# or

curl https://www.cloudflare.com/cdn-cgi/trace/ -x socks5://127.1:40000  # local dns mode

# or

curl https://www.cloudflare.com/cdn-cgi/trace/ -x http://127.1:40000  # http mode

```

```bash
...
sni=plaintext
warp=on
# 👆wrap on！
gateway=off
...
```
