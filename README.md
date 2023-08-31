# Misc. scripts and files, perhaps useful to no one but me.


* **ips_to_cidr.py**: script to convert an IPs file (one IP per line, first arg) to CIDRs and then print out the CIDRs as a comma-delimited CSV with x number of CIDRs per row (second arg). `python3 ips_to_csv.py ips.txt 4 > ips.csv` 
* **create_ip_csvs_from_raw_scopes.pl**: script to take text files that have raw scopes that include individual IPs, CIDRs, and ranges (one per line) and outputting CSVs that have that raw scope item next to the individual IP. You need to edit the file to specify the labels and files.
* **data_file_to_csv.pl**: script that takes a file that has individual items on a line (like hostnames, ips, emails, etc) and outputs that data to a CSV file, using an optional parameter to define how many datums are on a row. 
* **parse_masscan_greppable.pl**: script to create two text files: 1) ip:ports and 2) ip / port / service summary
* **parse_gnmap_to_nmap.pl**: script to output nmap -sV and -sC command using ports and ips listed in a gnmap file. Typically, I work by enumerating IPs and then ports, and then using this to enumerate the version info on those ports, along with any default nmap scripts.
* **urls_chunking.pl**: script to create files chunked with urls based on a hard coded chunk size
