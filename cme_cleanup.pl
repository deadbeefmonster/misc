#!/usr/bin/perl
#
use strict;

my $filename = $ARGV[0];
my %data; # {'ip' => @array_of_lines_in_order}

open(my $fp, $filename) || die print "Could not open '$filename': $!\n";
while(<$fp>) {
    if (/^(.*)\s+(\d+\.\d+\.\d+\.\d+)\s+(\d+)\s+.*/) {
	my $method = $1;
	my $ip = $2;
	my $port = $3;
	if (!defined $data{$ip}) {
	    $data{$ip} = ();
	}
	push(@{$data{$ip}}, $_);
    }
}
close($fp);

foreach my $ip (keys %data) {
    foreach my $line (@{$data{$ip}}) {
	print $line;
    }
}
