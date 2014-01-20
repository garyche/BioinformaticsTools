#!/usr/bin/perl
use strict;
use warnings;


###This script takes in 70kFile and 46SpeciesFile and will print out only lines that exists in the 70k File
### It will then set, each coordinate found in the 46File that is a part of the 70k Coordiante, and set it to true
### If all of the coordiantes in the 70K were found, one would expect to see that every coordiante in the log file is set to "T" and the
### The number ofv coord in the log file is the same as the number of coord in the original 70k File

#### Usage: ./parser70K.pl 70KFile 46File > FileToOutputTo


my $in1 = $ARGV[0];

open (FLE1,$in1);

my %dict = ();

while (<FLE1>)
{
	my @line = split(" ",$_);
	my $chr = $line[2];
	my $pos = $line[3];
	$dict{$chr}{$pos} = "F";

	
}

close(FLE1);

my %log = ();

my $in2 = $ARGV[1];


open(FLE2,$in2);
while(<FLE2>)
{
	#my ($species,$chr,$nuc,$pos,) = split(" ",$_);
	chomp($_);
	my @line = split(" ",$_);
	my $chr= $line[1];
	my $pos = $line[3];
	

	if ( exists $dict{$chr}{$pos})
	{	
		print "$_\n";
		delete $dict{$chr}{$pos};
		$log{$chr}{$pos} = "T";
	}
	
	
}
close(FLE2);


## DUMPING DATA LOG
open (OUT, "> 46HashData.log");
foreach  my $key (keys %log)
{
	foreach my $key2 (keys %{$log{$key}} )
	{
		print OUT $key2." ".$log{$key}{$key2}."\n";
	}
}

close(OUT);