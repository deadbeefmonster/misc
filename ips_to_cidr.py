#!/usr/bin/python3
#
import os
import sys
import ipaddress

if len(sys.argv) != 3:
    print("Usage: " + sys.argv[0] + " <ips file> <count of per row>")
    exit(1)

ip_filename = sys.argv[1]
ips_per_line = int(sys.argv[2])
if ips_per_line < 1 or ips_per_line > 10:
    ips_per_line = 4
ips_per_line_count = int(ips_per_line)

if os.access(ip_filename, os.R_OK) is False:
    print(f"ERROR: Could not open IP file '{ip_filename}' for reading.")
    exit(1)

ip_file_fp = open(ip_filename, 'r')

ips = ip_file_fp.read().split()
nets = [ipaddress.ip_network(_ip) for _ip in ips]
cidrs = ipaddress.collapse_addresses(nets)

for cidr in cidrs:
    cidr_str = format(cidr).replace("/32","")
    print(format(cidr_str), end='')
    ips_per_line_count = ips_per_line_count - 1;
    if ips_per_line_count == 0:
        ips_per_line_count = ips_per_line
        print("")
    else:
        print(",", end='')

print("")
