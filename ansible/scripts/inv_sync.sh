#!/usr/bin/env bash
set -euo pipefail

LAB_NAME="${1:-myfabric01}"
SRC="labs/${LAB_NAME}/clab-${LAB_NAME}/ansible-inventory.yml"
DST="ansible/inventories/${LAB_NAME}/hosts.yml"

mkdir -p "ansible/inventories/${LAB_NAME}"
test -f "${SRC}" || { echo "Inventory yok: ${SRC}"; exit 1; }

cp "${SRC}" "${DST}"
echo "Synced: ${SRC} -> ${DST}"