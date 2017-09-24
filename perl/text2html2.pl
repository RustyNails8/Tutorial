#!/usr/bin/perl
use strict;
use warnings;

open my $HTML, '>', 'MONIlog.html' or die $!;

print $HTML <<'_END_HEADER_';
<html>
<head><title></title></head>
<body>
_END_HEADER_

open my $IN, '<', 'GPA.AIXmonitor.2015.06.12-01.27.59.log' or die $!;
while (my $line = <$IN>) {
    # You probably want to do more work here.
    print $HTML $line;
}

print $HTML '</body></html>';
close $HTML or die $!;