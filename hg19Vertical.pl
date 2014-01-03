#!/bin/perl
# By: Gary Cheung
#This script will take the UCSC chromosome file, and assuming the file starts at 0
# It will create the Vertical Alignment output of the Nucleotides and Coordiantes

$in = $ARGV[0];

open(FLE,$in);

#print "Script Initaited\n";


$count = 1;
$skip = <FLE>;
while(<FLE>)
{


	
	if ($_ =~ /\w+/)
	{
	
		my $sequence = $_;
	#	print $sequence ."\n";
		my $seqLength = length($sequence);
		
		for(my $i =0; $i< $seqLength-1; $i++ )
		{
			chomp $nuc;
			#$nuc = ($nuc =~ s/" "//);
			my $nuc = substr($sequence,$i,1);
			
			print "$count $nuc \n";
			$count ++;
		
		}
		
		
	}
	
	
	
}