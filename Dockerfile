# https://hub.docker.com/r/bigga94/kong-oidc/dockerfile

#FROM kong
#FROM kong:1.5.1
FROM kong:centos

LABEL description="Kong + kong-oidc plugin"

USER root

#ENV KONG_PLUGINS="bundled, oidc"
#RUN luarocks install kong-oidc --local

RUN yum install -y git unzip && yum clean all

# RUN luarocks install kong-oidc
RUN git clone https://github.com/nokia/kong-oidc /tmp/kong-oidc \
 && cd /tmp/kong-oidc \
 && luarocks make kong-oidc-*.rockspec \
 && rm -rf /tmp/kong-oidc
 
#RUN luarocks install kong-plugin-api-key-access-control

USER kong
