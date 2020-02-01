FROM node:8-slim

ENV PORT 3000

ADD . /srv

WORKDIR /srv

RUN npm install --unsafe-perm

CMD ./bin/hubot -a slack
