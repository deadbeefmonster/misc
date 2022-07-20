#!/usr/bin/perl
#
use strict;
use Data::Dumper;
my %map;

open(my $fp, "internal_masscan.txt") || die print "Could not open internal_masscan.txt: $!\n";
while(<$fp>) {
    if (/Timestamp:\s+\d+\s+Host:\s+(\d+\.\d+\.\d+\.\d+)\s+.*Ports: (\d+)\/open\/tcp\/\/(.*)\/\/.*/) {
        my $ip = $1;
        my $port = $2;
        my $service = $3;
        if (!defined $map{$ip}) {
            my @tmp = ();
            $map{$ip} = \@tmp;
        }
        my %port_service = ( 'port' => $port, 'service' => $service );
        push (@{$map{$ip}}, \%port_service);
    }
}
close($fp);

# Summary
open(my $fp_summary, ">internal_masscan_summary.txt") || die print "Could not open internal_masscan_summary.txt: $!\n";
open(my $fp_ipports, ">internal_masscan_ipports.txt") || die print "Could not open internal_masscan_ipports.txt: $!\n";
foreach my $ip (sort keys %map) {
    print $fp_summary "$ip\n";
    my @ports;
    foreach my $port_service (@{$map{$ip}}) {
        print $fp_summary "+ " . $port_service->{'port'} . " (" . $port_service->{'service'} . ")\n";
        push (@ports, $port_service->{'port'});
    }
    my $ports_delim = join(",", sort @ports);
    print $fp_summary "= $ports_delim\n\n";
    print $fp_ipports $ip . ":" . $ports_delim . "\n";
}
close($fp_ipports);
close($fp_summary);
