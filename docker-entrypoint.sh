#!/usr/bin/env sh
set -ex

# Testnet support
if [ "$TESTNET" = true ]; then
  FLAGS='--testnet'
fi

# Graceful shutdown
trap 'pkill -TERM -P1; electron-cash $FLAGS daemon stop; exit 0' SIGTERM

# Run application
electron-cash $FLAGS daemon start

# Set config
electron-cash $FLAGS setconfig rpcuser ${ELECTRONCASH_USER}
electron-cash $FLAGS setconfig rpcpassword ${ELECTRONCASH_PASSWORD}
electron-cash $FLAGS setconfig rpchost 0.0.0.0
electron-cash $FLAGS setconfig rpcport 7100

# Loading wallet if exists
if [ -e "/home/electroncash/.electron-cash/wallets/default_wallet" ]
then
  echo "Loading wallet."
  electron-cash $FLAGS daemon load_wallet
fi

# Wait forever
while true; do
  tail -f /dev/null & wait ${!}
done
