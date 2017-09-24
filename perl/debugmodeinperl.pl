#!/usr/bin/perl
# guessnum.plx
use warnings;
use strict;

my $mode = "debug";
print "Enter debug mode!\n debug / nodebug\n";
print "[for default mode nodebug] - Press enter !   ";
my $guess = <STDIN>;
chomp($guess);
if ($mode eq $guess) {
        print "debug mode!\n";
        exit;
}else{
        print "nodebug mode!\n";
        exit;
}
