#!/usr/bin/perl
#
use strict;

my $ipfile = $ARGV[0];
my $zonefile = $ARGV[1];
my %ips;

if (! -e $ipfile || ! -e $zonefile) {
    print "Usage: $0 <ipfile> <zonefile>\n";
    exit 1;
}

open(my $fp, $ipfile) || die print "Could not open '$ipfile' for reading: $!\n";
while (<$fp>) {
    if (/(\d+\.\d+\.\d+\.\d+)/) {
        $ips{$1} = 1;
    }
}
close($fp);

open(my $fp, $zonefile) || die print "Could not open '$zonefile' for reading: $!\n";
while(<$fp>){
    if (/(.*)\s+\d+\s+IN\s+A\s+(.*)/ && $1 ne "@" && defined $ips{$2}) {
            print $1 . ":" . $2 . "\n";
    }
}
close($fp);
