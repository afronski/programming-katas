package main

import (
    "log"
    "net"
)

var sem = make(chan int, 100)

func echo(con net.PacketConn) {
    defer func() { <- sem } ()

    buf := make([]byte, 4096)
    nr, addr, err := con.ReadFrom(buf)

    if err != nil {
        log.Print(err)
        return
    }

    nw, err := con.WriteTo(buf[:nr], addr)

    if err != nil {
        log.Print(err)
        return
    }

    if nw != nr {
        log.Printf("received %d bytes but sent %d\n", nr, nw)
    }
}

func main() {
    log.SetFlags(log.Lshortfile)
    con, err := net.ListenPacket("udp", ":7")

    if err != nil {
        log.Fatal(err)
    }

    for {
        sem <- 1
        go echo(con)
    }

    err = con.Close()

    if err != nil {
        log.Fatal(err)
    }
}