#!/bin/bash

## Create directory to save rolling packet captures

mkdir -p /root/master-logs
chmod g+w /root/master-logs

## Use $! to capture the process ID of the last job that was backgrounded (tcpdump), and save it to a variable called TCPDUMP_PID
## Run tcpdump on all interfaces

/usr/sbin/tcpdump -s0 -w /root/master-logs/`hostname`.pcap -W 4 -C 300 -i any &TCPDUMP_PID=$!

## Run strace for confd and capture strace job PID from $!

strace -tt -o /root/master-logs/confd_trace.txt -s 1024 -f -T -v -e  trace=setsockopt,getsockopt,getsockname,bind,listen,recv,socket,recvmsg,send,sendmsg,ioctl,connect,poll,close,fcntl -p `pgrep [c]onfd` &STRACE_PID=$!

## Check confd.log for following string - "killed due to no ticks", once that is found, terminate tail process via --pid, wait 10 seconds, then terminate tcpdump and strace.

tail --follow=name --pid=$TCPDUMP_PID -n0 /var/log/cisco/confd/confd.log | while read line; do
echo $line | awk "/killed due to no ticks/{system(\"sleep 10; kill $TCPDUMP_PID; kill $STRACE_PID\")}"
done &

## Remove tcpdump, strace and tail from the jobs table, so processes do not get SIGHUP when we close the shell
disown -a -h
