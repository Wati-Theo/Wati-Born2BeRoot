#!/bin/bash

print_architecture=`uname -a`
print_CPU_physical=`grep "physical id" /proc/cpuinfo | sort | uniq | wc -l`
print_vCPU=`cat /proc/cpuinfo | grep processor | wc -l`
print_mem_usage=`free -m | grep Mem | awk '{print $3 "/" $2 "MB"}'`
print_mem_usage_percent=`free -m | grep Mem | awk '{printf("(%.2f%%)\n", $3 / $2 * 100)}'`
print_disk_usage1=`df --total -m | grep total | awk '{print $3 "/"}'`
print_disk_usage2=`df --total -BG | grep total | awk '{print $4 " (" $5 ")"}'`
print_CPU_load=`top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}'`
print_last_boot=`last reboot | head -1 | awk '{printf("%s %s %s %s", $5, $6, $7, $8)}'`
print_LVM_use=`lsblk | grep LVM | awk '{if ($1) {print "yes";exit;} else {print "no"; exit}}'`
print_TCP=`ss -s | grep TCP: | awk '{print $2}'`
print_User_log=`who | wc -l`
print_IP=`hostname -I | awk '{print $1}'`
print_MAC=`cat /sys/class/net/enp0s3/address`
print_sudo=`cat /var/log/sudo/sudo.log | grep -o 'TTY' | wc -l`

echo "	#Architecture: ${print_architecture}"
echo "	#CPU physical : ${print_CPU_physical}"
echo "	#vCPU : ${print_vCPU}"
echo "	#Memory Usage: ${print_mem_usage} ${print_mem_usage_percent}"
echo "	#Disk Usage: ${print_disk_usage1}${print_disk_usage2}"
echo "	#CPU load: ${print_CPU_load}"
echo "	#Last boot: ${print_last_boot}"
echo "	#LVM use: ${print_LVM_use}"
echo "	#Connexions TCP : ${print_TCP} ESTABLISHED"
echo "	#User log: ${print_User_log}"
echo "	#Network: IP ${print_IP} (${print_MAC})"
echo "	#Sudo : ${print_sudo} cmd"
