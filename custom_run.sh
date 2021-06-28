#!/bin/sh

envsubst </etc/grafana/provisioning/notifiers/notifiers_tmp.yaml >/etc/grafana/provisioning/notifiers/notifiers.yaml
. /run.sh