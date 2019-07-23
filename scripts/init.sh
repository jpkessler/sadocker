#!/bin/sh

## RUNTIME ARGS
. `dirname $0`/basics.sh
SAUPDATE=0

# create directory
umask 022
mkdir -p ${SADIR}/.razor

# razor update
[ -s ${SADIR}/.razor/razor-agent.conf ] || {
	razor-admin -home=${SADIR}/.razor -register
	razor-admin -home=${SADIR}/.razor -create
	razor-admin -home=${SADIR}/.razor -discover
	SAUPDATE=1
}

# spamassassin update
sa-update -v --nogpg \
	  --allowplugins \
	  --channelfile ${SAETC}/channels.txt \
	  && SAUPDATE=1

# permissions
chown -R ${USER}:${GROUP} ${SADIR} ${SADIR}

# restart spamd, if required
[ "${SAUPDATE}" -eq 1 ] && {
	echo "RECOMPILING RULESET"
	sa-compile
	[ -s ${SAPID} ] && {
		echo "RESTARTING SPAMASSASSIN"
		kill -HUP `cat ${SAPID}`
	}
}

# needed during build phase
exit 0

