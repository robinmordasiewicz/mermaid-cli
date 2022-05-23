FROM ubuntu:latest

ENV TZ="America/Toronto"
ARG DEBIAN_FRONTEND=noninteractive

ENV CHROME_BIN="/usr/bin/chromium-browser" \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD="true"

RUN apt-get --yes update \
    && apt-get --yes upgrade \
    && apt-get -y install apt-utils fontconfig curl sudo

RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
RUN apt-get -y install nodejs

RUN apt-get -y install chromium-browser fonts-noto-cjk fonts-noto-color-emoji \
    xfonts-terminus fonts-dejavu fonts-freefont-ttf fonts-font-awesome \
    fonts-inconsolata fonts-linuxlibertine \
    && fc-cache -f

RUN npm install -g @mermaid-js/mermaid-cli

RUN groupadd -g 1000 ubuntu
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g 1000 -G sudo -u 1000 ubuntu
RUN touch /home/ubuntu/.sudo_as_admin_successful
RUN touch /home/ubuntu/.hushlogin
RUN chown -R ubuntu:ubuntu /home/ubuntu
USER ubuntu:ubuntu

WORKDIR /home/ubuntu

ADD puppeteer-config.json  /puppeteer-config.json
#ENTRYPOINT ["/usr/bin/mmdc", "-p", "/puppeteer-config.json"]
#CMD [ "--help" ]

