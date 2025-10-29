#!/usr/bin/perl
#
use strict;

my $ts = scalar localtime();
print "[$ts] Trying... ";
my $current_position = `cliclick p`;
$current_position =~s/\s+$//;
if ($current_position =~ /([0-9-]+),([0-9-]+)/) {
    my $x = $1;
    my $y = $2;
    
    my $x2 = $x;
    my $y2 = $y;
    $x2++;
    $y2++;
    `cliclick m:$x2,$y2`;
    sleep 1;
    `cliclick m:$x,$y`;
    sleep 1;
    `cliclick kd:shift`;
    sleep 0.1;
    `cliclick ku:shift`;
    print "OK ($current_position -> $x,$y:$x2,$y2)";
}
else {
    print "NOT OK ($current_position)";
}
print "\n";
