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
    # Instalar kong-oidc versão 1.1.0FROM kong:centos

LABEL description="Kong + kong-oidc plugin"
USER root

# Atualizar sistema e instalar dependências básicas
RUN yum update -y && \
    yum install -y git unzip curl && \
    yum clean all

# lua-resty-openidc 1.6.1
RUN cd /tmp && \
    curl -L https://github.com/zmartzone/lua-resty-openidc/archive/v1.6.1.zip -o openidc.zip && \
    unzip openidc.zip && \
    mkdir -p /usr/local/share/lua/5.1/resty && \
    cp -r lua-resty-openidc-1.6.1/lib/resty/* /usr/local/share/lua/5.1/resty/ && \
    rm -rf /tmp/*

# kong-oidc 1.1.0
RUN cd /tmp && \
    curl -L https://github.com/nokia/kong-oidc/archive/v1.1.0.zip -o kong-oidc.zip && \
    unzip kong-oidc.zip && \
    mkdir -p /usr/local/share/lua/5.1/kong/plugins/oidc && \
    cp -r kong-oidc-1.1.0/kong/plugins/oidc/* /usr/local/share/lua/5.1/kong/plugins/oidc/ && \
    rm -rf /tmp/*

# lua-resty-jwt
RUN cd /tmp && \
    curl -L https://github.com/SkyLothar/lua-resty-jwt/archive/master.zip -o jwt.zip && \
    unzip jwt.zip && \
    cp -r lua-resty-jwt-master/lib/resty/* /usr/local/share/lua/5.1/resty/ && \
    rm -rf /tmp/*

# lua-resty-session
RUN cd /tmp && \
    curl -L https://github.com/bungle/lua-resty-session/archive/v2.26.zip -o session.zip && \
    unzip session.zip && \
    cp -r lua-resty-session-2.26/lib/resty/* /usr/local/share/lua/5.1/resty/ && \
    rm -rf /tmp/*

# lua-resty-hmac (fork compatível com OpenSSL moderno)
RUN cd /tmp && \
    curl -L https://github.com/jkeys089/lua-resty-hmac/archive/refs/tags/v0.06.zip -o hmac.zip && \
    unzip hmac.zip && \
    cp -r lua-resty-hmac-0.06/lib/resty/* /usr/local/share/lua/5.1/resty/ && \
    rm -rf /tmp/*

    
# RUN luarocks install kong-oidc

USER kong
