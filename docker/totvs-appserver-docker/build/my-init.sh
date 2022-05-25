#!/usr/bin/env bash
echo "------------------------------------------------"
echo "            my-init.sh appserver                "
echo "------------------------------------------------"

# Configurando DBAccess
export DBACCESS_SERVER=${DBACCESS_SERVER:-${DBACCESS_PORT_7890_TCP_ADDR}}
export DBACCESS_ALIAS=${DBACCESS_ALIAS:-protheus}
export DBACCESS_PORT=${DBACCESS_PORT:-7890}

echo "------------------------------------------------"
echo "            replace appserver.ini               "
echo "------------------------------------------------"

/bin/sed 's/{{DBACCESS_SERVER}}/'"${DBACCESS_SERVER}"'/' -i /totvs12/protheus/bin/appserver/appserver.ini
/bin/sed 's/{{DBACCESS_ALIAS}}/'"${DBACCESS_ALIAS}"'/' -i /totvs12/protheus/bin/appserver/appserver.ini
/bin/sed 's/{{DBACCESS_PORT}}/'"${DBACCESS_PORT}"'/' -i /totvs12/protheus/bin/appserver/appserver.ini

echo "------------------------------------------------"
echo "          result appserver.ini                  "
echo "------------------------------------------------"
cat /totvs12/protheus/bin/appserver/appserver.ini

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/totvs12/protheus/bin/appserver
export PATH=$PATH:/totvs12/protheus/bin/appserver

# Aguardando conectividade com o dbaccess
echo "Waiting for dbaccess to boot up..."
attempts=0
max_attempts=30
while ( nc ${DBACCESS_SERVER} ${DBACCESS_PORT} < /dev/null || nc 127.0.0.1 ${DBACCESS_PORT} < /dev/null )  && [[ $attempts < $max_attempts ]] ; do
    attempts=$((attempts+1))
    sleep 1;
    echo "waiting... (${attempts}/${max_attempts})"
done

exec "/totvs12/protheus/bin/appserver/appsrvlinux"
