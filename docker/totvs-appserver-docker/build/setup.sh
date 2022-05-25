#!/usr/bin/env bash
mkdir -p /totvs12/protheus/apo
mkdir -p /totvs12/protheus/bin/appserver
chmod 777 /totvs12/protheus/bin/appserver/*.so
# cp /build/my-init.sh /usr/local/bin/my-init.sh
cp /build/appserver.ini /totvs12/protheus/bin/appserver/appserver.ini
