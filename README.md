# ovpn-admin
Simple web UI to manage OpenVPN users and their certificates (from https://github.com/flant/ovpn-admin) 

## Environment Variables
| Name                | Description                                                  | Default            |
| ------------------- | ------------------------------------------------------------ | ------------------ |
| EASYRSA_CERT_EXPIRE | Certificate expiration (in days)                             | 730                |
| EASYRSA_CA_EXPIRE   | CA certificate expiration (in days)                          | 3650               |
| OVPN_SERVER         | HOST:PORT:PROTOCOL for clients connecting to OpenVPN server  | 127.0.0.1:7777:tcp |
| OVPN_NETWORK        | NETWORK/MASK_PREFIX for network assigned to clients          | 172.16.100.0/24    |

more options: https://github.com/flant/ovpn-admin#usage

