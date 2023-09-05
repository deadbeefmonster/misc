#!/usr/bin/perl
#
use strict;


my $filename = $ARGV[0];
open(my $fp, $filename) || die print "Could not open filename '$filename': $!\n";
while (<$fp>) {
    my $line = $_;
    if ($line =~ /open/ && $line =~ /Host:\s+(\d+\.\d+\.\d+\.\d+).*Ports:\s+(.*)/) {
	my $ip = $1;
	my $ports_tmp = $2;
	my @ports;
	foreach my $ports_tmp_datum (split(/,/, $ports_tmp)) {
	    if ($ports_tmp_datum =~ /(\d+)\/open\/(.*)\/\/(.*)\/\/(.*)\//) {
		my $port = $1;
		my $proto = $2;
		my $service = $3;
		my $service_desc = $4;

		my $port_filename = $proto.$port . ".txt";
		open(my $fp2, ">>", $port_filename) || die print "Could not open '$port_filename' for append writing: $!\n";
		print $fp2 $ip . "\n";
		close($fp2);
		print "[+] Wrote to $port_filename $ip\n";
	    }
	}
    }
}
close($fp);
