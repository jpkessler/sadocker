#!/bin/sh
#
# Dockerfile for DockerHub automatic build of postfwd - http://postfwd.org/docker
#
# If you want to rebuild it, go to the top directory (usually 'cd ..') and type in:
#
#	docker build -f docker/Dockerfile-autobuild -t postfwd:mybuild .
#
# To run a container from it, use:
#
#	docker run -it postfwd:mybuild
#
# or with more options (postfwd2 on port 10050, postfwd.cf in /path/to/ruleset):
#
#	docker run -it -e PROG=postfwd2 -e PORT=10050 -v /path/to/ruleset:/etc/postfwd:ro postfwd:mybuild
#

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

exit 0

