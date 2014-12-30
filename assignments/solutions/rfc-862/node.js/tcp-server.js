"use strict";

const net = require("net");
const server = net.createServer(function (connection) {
  connection.pipe(connection);
});

server.listen(7, function () {
  console.info("Echo Server bound to 'tcp://127.0.0.1:7'.");
});