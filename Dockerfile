FROM dockerfile/nodejs

RUN mkdir -p /src
WORKDIR /src
ADD . /src/
RUN npm install

CMD ["node", "app.js"]
