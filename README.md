# Misc. scripts and files, perhaps useful to no one but me.


* **ips_to_cidr.py**: a little script to convert an IPs file (one IP per line, first arg) to CIDRs and then print out the CIDRs as a comma-delimited CSV with x number of CIDRs per row (second arg). `python3 ips_to_csv.py ips.txt 4 > ips.csv` 
* **create_ip_csvs_from_raw_scopes.pl**: script to take text files that have raw scopes that include individual IPs, CIDRs, and ranges (one per line) and outputting CSVs that have that raw scope item next to the individual IP. You need to edit the file to specify the labels and files.
