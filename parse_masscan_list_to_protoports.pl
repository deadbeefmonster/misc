#!/usr/bin/perl
#
use strict;

my $masscan_list_file = $ARGV[0];
open(my $fp, $masscan_list_file) || die print "Could not open '$masscan_list_file': $!\n";
while(<$fp>) {
        if (/open\s+([a-z]+)\s+(\d+)\s+(\d+\.\d+\.\d+\.\d+)\s+\d+/) {
                my $proto = $1;
                my $port = $2;
                my $ip = $3;
                my $out_filename = $proto . $port . "-masscan_top100ports.txt";
                open(my $fp2, ">>$out_filename") || die print "Unable to open '$out_filename': $!\n";
                print $fp2 $ip . "\n";
                close($fp2);
        }
}
close($fp);
