# https://hub.docker.com/r/bigga94/kong-oidc/dockerfile

#FROM kong
FROM kong:centos

LABEL description="Kong + kong-oidc plugin"

USER root

#RUN yum install -y git unzip && yum clean all
RUN yum update -y && \
    yum install -y git unzip curl && \
    yum clean all

# Instalar kong-oidc manualmente
RUN cd /tmp && \
    # Baixar e instalar lua-resty-openidc
    curl -L https://github.com/zmartzone/lua-resty-openidc/archive/refs/heads/master.zip -o openidc.zip && \
    unzip openidc.zip && \
    cd lua-resty-openidc-master && \
    mkdir -p /usr/local/share/lua/5.1/resty && \
    cp -r lib/resty/* /usr/local/share/lua/5.1/resty/ && \
    # Baixar e instalar kong-oidc
    cd /tmp && \
    git clone https://github.com/nokia/kong-oidc.git && \
    cd kong-oidc && \
    mkdir -p /usr/local/share/lua/5.1/kong/plugins/oidc && \
    cp -r kong/plugins/oidc/* /usr/local/share/lua/5.1/kong/plugins/oidc/ && \
    # Limpeza
    cd / && rm -rf /tmp/*

# RUN luarocks install kong-oidc

USER kong
