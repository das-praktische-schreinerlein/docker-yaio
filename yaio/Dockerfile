#
# Creates a docker container with Yaio
#
FROM java:openjdk-8u45-jdk

MAINTAINER Michael Schreiner <michael.schreiner@your-it-fellow.de>

USER root

##########################################################
# Install utilities
##########################################################
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update -q \
    && apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
        curl \
        ghostscript \
        graphviz \
        less \
        sudo \
        telnet \
        unzip \
        wget \
        xfonts-base \
        xfonts-75dpi \
    && apt-get autoremove -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    && rm -rf /var/lib/apt/lists/*

# install wkhtmltopdf for yaio-webshot-service
RUN wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-jessie-amd64.deb \
    && dpkg -i wkhtmltox-0.12.2.1_linux-jessie-amd64.deb \
    && apt-get -y -f install \
    && dpkg -i wkhtmltox-0.12.2.1_linux-jessie-amd64.deb \
    && rm wkhtmltox-0.12.2.1_linux-jessie-amd64.deb;

##########################################################
# Prepare yaio
##########################################################
RUN useradd -ms /bin/bash -d /opt/yaio_home yaio
COPY build/ overrides/OVERWRITE/ /opt/yaio_home/
COPY installer/ /opt/yaio_home/installer/

RUN chown -R yaio /opt/yaio_home && chmod +x /opt/yaio_home/sbin/*.sh /opt/yaio_home/config/*.sh /opt/yaio_home/installer/*.sh
RUN /opt/yaio_home/installer/install.sh

##########################################################
# Run-options
##########################################################

EXPOSE 8666
ENTRYPOINT ["/opt/yaio_home/sbin/start-yaioapp.sh"]
CMD [""]

