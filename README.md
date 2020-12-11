# docker-electron-cash-daemon

**Electron-Cash client 4.2.3 running as a daemon in docker container with JSON-RPC enabled.**

### Ports

* `7100` - JSON-RPC port.

### Volumes

* `/data` - user data folder (on host it usually has a path ``/home/user/.electron-cash``).


## Getting started

#### docker

Running with Docker:

```bash
chown -R 1000:1000 ./data
docker run --rm --name electron-cash-daemon \
    --env TESTNET=false \
    --publish 127.0.0.1:7000:7000 \
    --volume /srv/electrum:/data \
    internetportal/docker-electron-cash-daemon
```
```bash
docker exec -it electron-cash-daemon electron-cash create
docker exec -it electron-cash-daemon electron-cash daemon load_wallet
docker exec -it electron-cash-daemon electron-cash daemon status
docker exec -it electron-cash-daemon electron-cash getbalance
{
    "auto_connect": true,
    "blockchain_height": 660633,
    "connected": true,
    "default_wallet": "/home/electrum/.electrum/wallets/default_wallet",
    "fee_per_kb": 59261,
    "path": "/home/electrum/.electrum",
    "server": "blockstream.info",
    "server_height": 660633,
    "spv_nodes": 10,
    "version": "4.0.6"
}
```


#### docker-compose

[docker-compose.yml](https://github.com/vencis/docker-electron-cash-daemon/blob/master/docker-compose.yml) to see minimal working setup. When running in production, you can use this as a guide.

```bash
curl --data-binary '{"id":"1","method":"listaddresses"}' http://electrum:electrumz@localhost:7100
```

:exclamation:**Warning**:exclamation:

Always link electrum daemon to containers or bind to localhost directly and not expose 7100 port for security reasons.



