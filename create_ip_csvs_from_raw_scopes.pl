#!/usr/bin/perl
#
use strict;

my %files;
$files{'Grouping1'} = 'Grouping1.txt';
$files{'Grouping2'} = 'Grouping2.txt';
$files{'Grouping3'} = 'Grouping3.txt';

my %files_ip_map;

foreach my $filelabel (keys %files) {
    my $filename_in = %files{$filelabel};
    my $filename_out = $filelabel . "_ips.csv";
    print "filelabel...: $filelabel\n";
    print "filename in.: $filename_in\n";
    print "filename out: $filename_out\n";

    $files_ip_map{$filelabel} = ();

    open(my $fp_in, $filename_in) || die print "Could not open file '$filename_in' for reading: $!\n";
    open(my $fp_out, ">$filename_out") || die print "Could not open file '$filename_out' for writing: $!\n";
    while (<$fp_in>) {
        my $line = $_;
        $line =~ s/^\s+|\s+$//g;
        print "Processing '$line':\n";
        if ($line =~ /^\d+\.\d+\.\d+\.\d+$/) {
            push(@{$files_ip_map{$filelabel}}, $line);
            print $fp_out "$line,$line\n";
        }
        elsif ($line =~ /^\d+\.\d+\.\d+\.\d+\/\d+/ || $line =~ /\d+\s+\d+/) {
            my $command = "/usr/bin/prips $line";
            my $output = `$command`;
            my @ips = split(/\s+/,$output);
            foreach my $ip (@ips) {
                push(@{$files_ip_map{$filelabel}}, $ip);
                print $fp_out "$line,$ip\n";
            }
        }
        else {
            print "=> No idea what '$line' is, a hostname?\n";
        }
    }
    close($fp_in);
    close($fp_out);
}
