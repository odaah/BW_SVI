#!/bin/bash
 # Collect the current user's ssh and enable passwords
 echo -n "Enter the SSH password for $(whoami) "
 read -s -e password
 echo -ne '\n'
 echo -n "Enter the Enable password for $(whoami) "
 read -s -e enable
 echo -ne '\n'
# Feed the expect script a device list & the collected passwords

#execute the command on distro
for device in `cat ~/aggr_throughput/devices.txt`; do
 ./through_exp.exp $device $password $enable ;
done

echo -n '####################'
echo -ne '\n'
date
echo -ne '\n'
echo -n "output-bits: "
cat results.log  | grep output | awk '{print $5}' | awk '{ sum += $1 } END { print sum }'

echo -n "input-bits:  "
cat results.log  | grep input | awk '{print $5}' | awk '{ sum += $1 } END { print sum }'

echo -ne '\n'
echo -n "output-packets: "
cat results.log  | grep output | awk '{print $7}' | awk '{ sum += $1 } END { print sum }'

echo -n "input-packets:  "
cat results.log  | grep input | awk '{print $7}' | awk '{ sum += $1 } END { print sum }'
echo -n '####################'
echo -ne '\n'
