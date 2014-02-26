var Etcd = require('node-etcd');
var etcd = new Etcd(process.env.HOST, process.env.PORT);

var watcher = etcd.watcher(process.env.KEY);
watcher.on("set", function(data, headers){
    if (data) {
        if (data.prevNode) {
            console.log("previous: ", data.prevNode.value);
        }
        if (data.node) {
            console.log("current:  ", data.node.value);
        }
        console.log();
    }
});
