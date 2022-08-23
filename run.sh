#!/usr/bin/bash

cargo b --release 
export CARGO_TARGET_DIR="/home/sj/Code/rust-tcp-testing/target"
sudo setcap cap_net_admin=eip ${CARGO_TARGET_DIR}/release/thunder
${CARGO_TARGET_DIR}/release/thunder &
pid=$!
sudo ip addr add 192.168.0.1/24 dev tun0
sudo ip link set up dev tun0
trap "kill $pid" INT TERM
wait $pid