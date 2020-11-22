## Scenario:
- 2 VMs act as Master / Slave
- Master VM reboots Slave VM, the message ```killed due to no ticks``` appears in the following log for Master VM ```/var/log/cisco/confd/confd.log```

## Aim:
- Capture tcpdump and strace information on both Master and Slave VMs prior to the Master rebooting the Slave
