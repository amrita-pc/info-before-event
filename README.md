## Scenario:
- 2 VMs act as Master / Slave
- Master VM reboots Slave VM, the message appearing in the following log for Master VM ```/var/log/cisco/confd/confd.log``` is ```killed due to no ticks```

## Aim:
- Capture tcpdump and strace information on both Master and Slave VMs prior to the Master rebooting the Slave
