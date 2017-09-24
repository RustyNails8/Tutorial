#!/usr/bin/perl
use strict;
use warnings;

open my $HTML, '>', 'MoniLog.html' or die $!;

print $HTML <<'_END_HEADER_';
<html>
<head><title></title></head>
<body>
<pre>
_END_HEADER_

open my $IN, '<', 'input.txt' or die $!;
print $HTML while <$IN>;


print $HTML '</pre></body></html>';
close $HTML or die $!;