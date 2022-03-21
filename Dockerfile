FROM neomediatech/ubuntu-base:20.04 AS builder

ARG OVPN_ADMIN_VERSION=1.7.5
WORKDIR /tmp
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://github.com/flant/ovpn-admin/releases/download/$OVPN_ADMIN_VERSION/ovpn-admin-linux-amd64.tar.gz && \
    tar xvfz ovpn-admin-linux-amd64.tar.gz

FROM neomediatech/ubuntu-base:20.04

ENV VERSION=$VERSION \
    SERVICE=ovpn-admin

LABEL maintainer="docker-dario@neomediatech.it" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-type=Git \
      org.label-schema.vcs-url=https://github.com/Neomediatech/${SERVICE} \
      org.label-schema.maintainer=Neomediatech

COPY --from=builder /tmp/ovpn-admin /
RUN apt-get update && apt-get install -y --no-install-recommends openvpn easy-rsa  && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
    ln -s /ovpn-admin /usr/local/bin && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apt/* /var/cache/distfiles/*

COPY entrypoint.sh /entrypoint.sh

COPY openssl-easyrsa.cnf /
#COPY easyrsa /usr/local/bin
#RUN chmod +x /entrypoint.sh /usr/local/bin/easyrsa
RUN chmod +x /entrypoint.sh 

ENTRYPOINT /entrypoint.sh
WORKDIR /data/openvpn

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/tini","--","ovpn-admin"]

