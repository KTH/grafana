FROM grafana/grafana:8.4.3-ubuntu

COPY notifiers.yaml /etc/grafana/provisioning/notifiers/notifiers_tmp.yaml

COPY datasource.yaml /etc/grafana/provisioning/datasources/datasource.yaml
COPY custom_run.sh /custom_run.sh

# Prepare for envsubst in custom_run.sh
USER root
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y apt-utils && \
    apt-get install -y gettext-base && \
    chmod a+rw -R /etc/grafana/provisioning/notifiers && \
    chmod a+x /custom_run.sh

USER grafana

COPY dashboard_provisioners.yaml /etc/grafana/provisioning/dashboards/provisioners.yml
RUN mkdir -p /var/lib/grafana/dashboards
ADD dashboards /var/lib/grafana/dashboards/

ENTRYPOINT [ "/custom_run.sh" ]
