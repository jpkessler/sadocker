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
	spamassassin-compiler \
	razor \
	spamassassin \
	&& rm -rf /var/cache/apk/*

# create user & group
RUN addgroup -S ${GROUP} && \
    adduser -S \
            -D -G ${GROUP} \
            -h ${SADIR} \
            ${USER}

# copy conf & init spamassassin
COPY ./conf/ ${SAETC}/
COPY ./scripts/ /
RUN /init.sh

# open port
EXPOSE ${PORT}

# update ruleset and start spamd
ENTRYPOINT exec /bin/sh -c '/init.sh; /run.sh'

