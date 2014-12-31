package main

import (
    "io"
    "log"
    "net"
)

func echo(connection net.Conn) {
    _, err := io.Copy(connection, connection)

    if err != nil {
        log.Print(err)
    }

    err = connection.Close()

    if err != nil {
        log.Print(err)
    }
}

func main() {
    log.SetFlags(log.Lshortfile)
    ln, err := net.Listen("tcp", ":7")

    if err != nil {
        log.Fatal(err)
    }

    for {
        connection, err := ln.Accept()

        if err != nil {
            log.Fatal(err)
        }

        go echo(connection)
    }

    err = ln.Close()

    if err != nil {
        log.Fatal(err)
    }
}