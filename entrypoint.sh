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
  cd /data/openvpn
fi

[ -n "$OVPN_CCD_PATH" ] && mkdir -p "$OVPN_CCD_PATH" || ok=1

exec "$@"
