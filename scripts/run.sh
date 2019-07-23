#!/bin/sh

## RUNTIME ARGS
. `dirname $0`/basics.sh

exec spamd	--username ${USER} --groupname ${GROUP} \
	--port ${PORT} \
	--nouser-config --syslog stderr \
	--pidfile ${SAPID} \
	--helper-home-dir ${SADIR} \
	--ip-address \
	--allowed-ips 0.0.0.0/0

