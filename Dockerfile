# https://hub.docker.com/r/bigga94/kong-oidc/dockerfile

#FROM kong
FROM kong:centos

LABEL description="Kong + kong-oidc plugin"

USER root

#RUN yum install -y git unzip && yum clean all
RUN yum update -y && \
    yum install -y git unzip curl && \
    yum clean all

# Instalar versões compatíveis do kong-oidc e dependências
RUN cd /tmp && \
    # Instalar lua-resty-openidc versão 1.6.1 (compatível)
    curl -L https://github.com/zmartzone/lua-resty-openidc/archive/v1.6.1.zip -o openidc-1.6.1.zip && \
    unzip openidc-1.6.1.zip && \
    cd lua-resty-openidc-1.6.1 && \
    mkdir -p /usr/local/share/lua/5.1/resty && \
    cp -r lib/resty/* /usr/local/share/lua/5.1/resty/ && \
    # Instalar kong-oidc versão 1.1.0
    cd /tmp && \
    curl -L https://github.com/nokia/kong-oidc/archive/v1.1.0.zip -o kong-oidc-1.1.0.zip && \
    unzip kong-oidc-1.1.0.zip && \
    cd kong-oidc-1.1.0 && \
    mkdir -p /usr/local/share/lua/5.1/kong/plugins/oidc && \
    cp -r kong/plugins/oidc/* /usr/local/share/lua/5.1/kong/plugins/oidc/ && \
    # Instalar lua-resty-jwt
    cd /tmp && \
    curl -L https://github.com/SkyLothar/lua-resty-jwt/archive/master.zip -o jwt.zip && \
    unzip jwt.zip && \
    cd lua-resty-jwt-master && \
    cp -r lib/resty/* /usr/local/share/lua/5.1/resty/ && \
    # Instalar lua-resty-session
    cd /tmp && \
    curl -L https://github.com/bungle/lua-resty-session/archive/v2.26.zip -o session.zip && \
    unzip session.zip && \
    cd lua-resty-session-2.26 && \
    cp -r lib/resty/* /usr/local/share/lua/5.1/resty/ && \
    # Instalar lua-resty-hmac
    cd /tmp && \
    curl -L https://github.com/jkeys089/lua-resty-hmac/archive/refs/heads/master.zip -o hmac.zip && \
    unzip hmac.zip && \
    cd lua-resty-hmac-master && \
    cp -r lib/resty/* /usr/local/share/lua/5.1/resty/ && \
    # Limpeza
    cd / && rm -rf /tmp/*
    
# RUN luarocks install kong-oidc

USER kong
