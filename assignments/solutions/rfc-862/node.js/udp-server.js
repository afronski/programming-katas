"use strict";

const udp = require("dgram");
const socket = udp.createSocket("udp4");

socket.on("message", function (message, remote) {
  socket.send(message, 0, message.length, remote.port, remote.address);
});

socket.bind(7, function () {
  console.info("Echo Server bound to 'udp://127.0.0.1:7'.");
});