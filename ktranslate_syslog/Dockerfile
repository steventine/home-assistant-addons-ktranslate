#This is the base ktranslate image that we'll use to get the executables
FROM stevent111/steventine-ktranslate:latest as ktranslate_base

# Import the ktranslate executables into the base hassio addon image
FROM ghcr.io/home-assistant/amd64-base:latest

RUN apk add -U --no-cache ca-certificates libpcap aws-cli
RUN addgroup -g 1000 ktranslate && \
        adduser -D -u 1000 -G ktranslate -H -h /etc/ktranslate ktranslate

# Some people want to specify an alternative config dir. This lets them override with --build-arg CONFIG-DIR=my-new-dir
ARG CONFIG_DIR=config

COPY --from=ktranslate_base /etc/ktranslate/ /etc/ktranslate

RUN ls -lah /etc/ktranslate ; ln -sv /etc/ktranslate /etc/profiles ; ls -lah /etc/profiles/
RUN ln -sv /etc/ktranslate/mibs.db /etc/mib.db ; ls -lah /etc/mib.db/

COPY --from=ktranslate_base /usr/local/bin/ktranslate /usr/local/bin/ktranslate
COPY --from=ktranslate_base /usr/sbin/setcap /usr/sbin/setcap
COPY --from=ktranslate_base /usr/lib/libcap.so.2 /usr/lib/libcap.so.2
RUN setcap cap_net_raw=+ep /usr/local/bin/ktranslate

EXPOSE 8082

USER ktranslate

####### Custom changes on top of ktranslate_base

# Copy root filesystem
COPY rootfs /

ENTRYPOINT ["/usr/bin/start_ktranslate.sh"]