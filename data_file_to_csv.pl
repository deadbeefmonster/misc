#!/usr/bin/perl
#
use strict;
use Scalar::Util qw(looks_like_number);

my $data_file = $ARGV[0];
my $data_per_row = (defined $ARGV[1] && looks_like_number($ARGV[1])) ? $ARGV[1] : 4;
my $data_per_row_count = $data_per_row;
my $csv_file = $data_file;
$csv_file =~ s/\./_/g;
$csv_file .= scalar time();
$csv_file .= '.csv';

if (!$data_file) {
    print "$0 <data file, one datum per line> [optional datums per row, default is 4]\n";
    exit;
}
elsif (! -r $data_file) {
    print STDERR "NOT OK - Could not open data file '$data_file' for reading.\n";
    exit(1);
}

print STDERR "OK - Parsing Data file '$data_file' with $data_per_row datums per row.\n";

open (my $fp, $data_file) || die print STDERR "NOT OK - Could not open data file '$data_file' for reading: $!\n";
while (<$fp>) {
    my $datum = $_;
    $datum =~ s/^\s+//;
    $datum =~ s/\s+$//;
    print "$datum";
    $data_per_row_count--;
    if ($data_per_row_count == 0) {
        $data_per_row_count = $data_per_row;
        print "\n";
    }
    else {
        print ",";
    }
}
close($fp);
