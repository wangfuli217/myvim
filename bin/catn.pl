#!/usr/bin/perl
" file: catn.pl
my $sep = shift || "";
my $num = shift || 0;
$sep .= ($num > 0) ? (" " x $num) : "\t";
while (<>) { print "$.$sep$_"; }
