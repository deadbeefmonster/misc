#!/usr/bin/perl
#
use strict;

my $batch_size=20;
my $x = 0;
my @urls=();
my $file_count=0;

open(my $fp, "urls_to_test_manually.txt") || die print "Could not open 'urls_to_test_manually.txt': $!\n";
while (<$fp>) {
    if (/^http/) {
        push @urls, $_;
        $x++;
        if (($x % $batch_size) == 0) {
            my $filename = "urls_to_test_manually-" . $file_count . ".txt";
            open (my $fp2, ">$filename") || die print "Could not open '$filename' for writing: $!\n";
            print $fp2 join('',@urls);
            close($fp2);
            $file_count++;
            @urls=();
        }
    }
}
close($fp);
if (@urls) {
    my $filename = "urls_to_test_manually-" . $file_count . ".txt";
    open (my $fp2, ">$filename") || die print "Could not open '$filename' for writing: $!\n";
    print $fp2 join('',@urls);
    close($fp2);
}
