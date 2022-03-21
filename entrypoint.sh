#!/bin/bash

if [ ! -d /data/openvpn/easyrsa/pki ]; then
  mkdir -p /data/openvpn/easyrsa
  cd /data/openvpn/easyrsa/
  easyrsa init-pki
  cp -R /usr/share/easy-rsa/* /data/openvpn/easyrsa/pki
  cp /openssl-easyrsa.cnf pki/
  echo "ca" | easyrsa build-ca nopass
  easyrsa build-server-full server nopass
  easyrsa gen-dh
  openvpn --genkey --secret ./pki/ta.key
  easyrsa gen-crl
  chmod 755 pki/
  chmod 644 pki/crl.pem
  mkdir -p /etc/openvpn/ccd
  cd /data/openvpn
fi

exec "$@"
