#!/usr/bin/env bashio

#To keep the API KEY off the command line, have ktranslate pick it up from the ENV var
export NEW_RELIC_API_KEY="$(bashio::config 'new_relic_api_key')"

NEW_RELIC_ACCOUNT_ID="$(bashio::config 'new_relic_account_id')"

ktranslate -listen off -mapping /etc/ktranslate/config.json -geo /etc/ktranslate/GeoLite2-Country.mmdb \
        -udrs /etc/ktranslate/udr.csv -api_devices /etc/ktranslate/devices.json -asn /etc/ktranslate/GeoLite2-ASN.mmdb \
        -snmp /etc/ktranslate/snmp-base-hassio.yaml -log_level debug -nr_account_id="$NEW_RELIC_ACCOUNT_ID" \
        -metrics=jchf -tee_logs=true -dns=local -service_name=home-assistant-ktranslate nr1.syslog
