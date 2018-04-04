FROM certbot/dns-google as obtain-cert

ADD https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN set -x && \
  apk add --no-cache curl ca-certificates && \
  chmod +x /usr/local/bin/kubectl

ADD deployhook.sh  /usr/local/bin/deployhook.sh
RUN chmod +x /usr/local/bin/deployhook.sh
