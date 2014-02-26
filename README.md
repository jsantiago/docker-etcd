Start etcd:

    docker run -d -i -t -p 4001:4001 -p 7001:7001 coreos/etcd

To build:

    docker -rm -t docker-etcd .

To run:

    HOST="127.0.0.1"
    PORT="4001"
    KEY="message"
    docker run -rm -e HOST=$HOST -e PORT=$PORT -e KEY=$KEY -i -t docker-etcd

To set messages:

    HOST="127.0.0.1"
    PORT="4001"
    KEY="message"
    curl http://$HOST:$PORT/v2/keys/$KEY -XPUT -d value="What"
    curl http://$HOST:$PORT/v2/keys/$KEY -XPUT -d value="is"
    curl http://$HOST:$PORT/v2/keys/$KEY -XPUT -d value="the"
    curl http://$HOST:$PORT/v2/keys/$KEY -XPUT -d value="current"
    curl http://$HOST:$PORT/v2/keys/$KEY -XPUT -d value="message"
    curl http://$HOST:$PORT/v2/keys/$KEY -XPUT -d value="?"

Runs [etcd][2] in a [Docker][1] container. Includes a sample [NodeJS][3] app that uses [node-etcd][4] to listen for changes and outputs the current and previous values to the console.

[1]: https://www.docker.io/
[2]: https://coreos.com/using-coreos/etcd/
[3]: http://nodejs.org/
[4]: https://github.com/stianeikeland/node-etcd
