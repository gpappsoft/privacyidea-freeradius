FROM freeradius/freeradius-server:3.2.3-alpine
LABEL maintainer="Marco Moenig <marco@moenig.it>"

ARG PLUGIN_VERSION=3.4.2
COPY raddb/ /etc/raddb/
COPY docker-entrypoint.sh /

ADD https://raw.githubusercontent.com/privacyidea/FreeRADIUS/v${PLUGIN_VERSION}/privacyidea_radius.pm /usr/share/privacyidea/freeradius/
ADD https://raw.githubusercontent.com/privacyidea/FreeRADIUS/v${PLUGIN_VERSION}/dictionary.netknights /etc/raddb/dictionary

RUN apk update 
RUN apk add \
        perl \
        perl-config-inifiles \
        perl-data-dump \
        perl-try-tiny \
        perl-json \
        perl-lwp-protocol-https \
        perl-yaml-libyaml\
        perl-module-build
        
RUN perl -MCPAN -e 'install URI::Encode'   

RUN rm /etc/raddb/sites-enabled/inner-tunnel
RUN rm /etc/raddb/sites-enabled/default
RUN rm /etc/raddb/mods-enabled/eap
RUN echo DEFAULT Auth-Type := Perl >> /etc/raddb/users

EXPOSE 1812/udp
EXPOSE 1813/udp
EXPOSE 1812/tcp

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "radiusd" ]
