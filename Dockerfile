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
FROM alpine:latest

LABEL maintainer="SSDI - slim spamassassin docker image"

## RUNTIME ARGS
ENV PORT=783
ENV USER=spamassassin
ENV GROUP=spamassassin
ENV SADIR=/var/lib/spamassassin
ENV SAETC=/etc/mail/spamassassin

# install stuff
RUN apk update && apk add --no-cache \
	perl-mail-spamassassin \
	spamassassin-client \
	razor \
	spamassassin \
	&& rm -rf /var/cache/apk/*

# create user & directories
RUN addgroup -S ${GROUP} && \
    adduser -S \
            -D -G ${GROUP} \
            -h ${SADIR} \
            ${USER}

COPY ./conf/ ${SAETC}/
COPY ./scripts/ /

# open port
EXPOSE ${PORT}

# update ruleset and start spamd
ENTRYPOINT exec /bin/sh -c '/init.sh; /run.sh'

