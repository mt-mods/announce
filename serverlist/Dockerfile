FROM alpine:3.17.3

RUN apk add --no-cache nodejs npm git python3 py3-pip patch

RUN git clone https://github.com/minetest/serverlist /serverlist &&\
    cd /serverlist &&\
    npm install dot commander mkdirp &&\
    cd static &&\
    ../node_modules/dot/bin/dot-packer -s . &&\
    cd /serverlist &&\
    pip install -r requirements.txt

COPY config.py /serverlist/config.py

EXPOSE 8080
ENTRYPOINT sh -c 'cd /serverlist && ./server.py'