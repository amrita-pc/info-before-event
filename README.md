## Scenario:
- 2 VMs act as Master / Slave
- Master VM reboots Slave VM daily, the message ```killed due to no ticks``` appears in the following log for Master VM ```/var/log/cisco/confd/confd.log```

## Aim:
- Capture tcpdump and strace information on both Master and Slave VMs prior to the Master rebooting the Slave

This idea was adopted from RedHat's article on rolling packet captures along with tracing logs in logfiles.
