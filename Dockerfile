FROM node:current

RUN  apt-get update \
     && apt-get install -y wget gnupg ca-certificates \
     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
     && apt-get update \
     && apt-get install -y google-chrome-stable \
     && rm -rf /var/lib/apt/lists/* \
     && wget --quiet https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -O /usr/sbin/wait-for-it.sh \
     && chmod +x /usr/sbin/wait-for-it.sh

USER root
ENV NODE_PATH=/usr/local/lib/node_modules
#ADD package.json /
RUN npm --global config set user root && \
    npm --global install puppeteer puppeteer-extra puppeteer-extra-plugin-recaptcha puppeteer-extra-plugin-stealth --unsafe-perm

RUN mkdir /app && cd /app
WORKDIR /app




