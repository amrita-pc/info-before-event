#!/bin/bash

## Create directory to save rolling packet captures

mkdir -p /root/slave-logs
chmod g+w /root/slave-logs

## Run tcpdump on all interfaces and background the process

/usr/sbin/tcpdump -s0 -w /root/slave-logs/`hostname`.pcap -W 4 -C 300 -i any &

## Run strace for confd and background the process

strace -tt -o /root/slave-logs/confd_trace.txt -s 1024 -f -T -v -e  trace=setsockopt,getsockopt,getsockname,bind,listen,recv,socket,recvmsg,send,sendmsg,ioctl,connect,poll,close,fcntl -p `pgrep [c]onfd` &

## Remove tcpdump and strace from the jobs table, so processes do not get SIGHUP when we close the shell
disown -a -h
