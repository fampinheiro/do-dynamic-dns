FROM alpine

WORKDIR /code

ENV APK_PACKAGES bash alpine-sdk ca-certificates tini
ENV NODE_ENV production

RUN apk \
    --update-cache \
    --update add \
    "nodejs<8.0.0" \
    ${APK_PACKAGES} \
    && rm -rf /var/cache/apk/*

# COPY package.json yarn.lock ./
COPY package.json ./

# Build
RUN npm install && npm cache clean

COPY . .

CMD [ "/sbin/tini", "node", "." ]
