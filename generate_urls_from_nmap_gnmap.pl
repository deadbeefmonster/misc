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
                
                #print "Service: $service IP: $ip Port: $port ($service_desc)\n";
                my $url = "";
                if ($service eq 'ssl|http' || $service eq 'http') {
                        if ($service =~ /ssl/) {
                                $url .= "https://";
                        } else {
                                $url .= "http://";
                        }
                        $url .= $ip . ":" . $port . "/";
                        print $url . "\n";
                }
                push @ports, $port;
            }
        }
    }
}
close($fp);
