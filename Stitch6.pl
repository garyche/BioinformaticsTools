#!/usr/bin/perl
use strict;
use warnings;
### Multiple Alignement File Stitcher
## This Program will Stitch together unplaced Nucleotides in MAF
## This program will output Vertically Aligned File for the 46 species

## SCRIPT IS VERY SPECIFIC FOR 46 Spcies MAF File found on UCSC 
use Data::Dumper;


my $in = $ARGV[0];






open (FLE, $in);

open (ERROR, ">error.log");
#open (OUT, >OUT );

#Going Through File line by line

## Hash of 46 species and header


### HASH OF ARRAY
# Species Header, isMatched

my $species = {};

my %species = (

hg19 => 'F',
panTro2 => 'F',
gorGor1 => 'F',
ponAbe2 => 'F',
rheMac2 => 'F',
papHam1 => 'F',
calJac1 => 'F',
tarSyr1 => 'F',
micMur1 => 'F',
otoGar1 => 'F',
tupBel1 => 'F',
mm9 => 'F',
dipOrd1 => 'F',
cavPor3 => 'F',
speTri1 => 'F',
oryCun2 => 'F',
ochPri2 => 'F',
vicPac1 => 'F',
turTru1 => 'F',
bosTau4 => 'F',
equCab2 => 'F',
felCat3 => 'F',
canFam2 => 'F',
myoLuc1 => 'F',
pteVam1 => 'F',
eriEur1 => 'F',
sorAra1 => 'F',
loxAfr3 => 'F',
proCap1 => 'F',
echTel1 => 'F',
dasNov2 => 'F',
choHof1 => 'F',
monDom5 => 'F',
macEug1 => 'F',
ornAna1 => 'F',
galGal3 => 'F',
taeGut1 => 'F',
anoCar1 => 'F',
xenTro2 => 'F',
tetNig2 => 'F',
fr2	  => 'F',
gasAcu1 => 'F',
oryLat2 => 'F',
danRer6 => 'F',
petMar1 => 'F',

);


for my $file  (keys %species)
{	
	no strict 'refs';
#	print "FILE IS $file\n";
	my $fileName = $file . "file";

#	print "Filename = $fileName\n";
	open($fileName,">",$fileName) or die "Sorry cant open $file";

}

	#Initialize Variable for human chr
	my $humanSeq ;
	my $humanLen ;
	my $humanStart ;	
	my $humanActualLen;
	my $humanDir;
	my $humanChr;
	




	
while (<FLE>)
{
	
		
		## The Current Line
		my $line = $_;
			

		## AS A PRECAUTION, RESET THE HUMAN SET THE HUMAN VARIABLE
		## EMPTY LINE
		if ($line =~ /^$/)
		{

	#		print Dumper(\%species);

			for my $key (keys %species)
				{
					
					if ($species{$key} eq 'F')
					{

						print "Species $key , Start $humanStart Length $humanActualLen\n";
						
						### Printing out
						my $fName = $key . "file";
						
						my $j =0;
						#my $position = $humanStart;
						### NOTE THE POSITION STARTS AT +1 
						my $position = $humanStart + 1;
						while ($j < $humanActualLen)
						{
						
						my $seqOut = substr($humanSeq,$j,1);
						if ($seqOut eq "-")
							{
								no strict 'refs';
								print $fName "$humanChr $humanDir - - - x - -\n";
								$j++;
							}
						else
							{ 
								no strict 'refs';
								print $fName "$humanChr $humanDir $position $seqOut - x - -\n"; 
								$position++;
								$j++;
							}
							
							### DATA CHECK FOR LENGTH
							my $end = $humanStart + $humanLen - 1;
						if($j == $humanActualLen)
						{
							print "Compare $key $j $humanActualLen \n";
					
							if ($position -1 != $end)
							{
								print ERROR "$position $end\n";
								print  ERROR "LENGTH ERROR $key $humanStart $humanActualLen\n";
							}
						}	
							
							
						}

					}
		
				}
				## CHECK TO SEE IF ALL SPECIES SET TO TRUE (T), 
	
				####reset Hash###
				for my $key (keys %species)
					{
						$species{$key} = 'F';
					}
		

			## Iterate through species hash
			## Output generic, human coord human nuc species name - 
			$humanSeq  = "ERROR";
			$humanLen  = "ERROR";
			$humanStart = "ERROR";
	#		print "------------------------------\n";
			next;
		}



		## SEQUENCE
		if ($line =~  "^s" )
		{
			
			## UPDATE SPECIES HASH, Set the found species to true. 
			my ($identity,  $chr, $startPos,$length,$direction,$srcSize,$nuc)	= split(/\s+/,$_);
			
			my($speciesName,$chrNum) = split(/\./,$chr);
			
	
				if (exists $species{$speciesName})
				{
					$species{$speciesName} = 'T';
				}
			
			
			if ($speciesName =~ "hg19")
			{
				$humanDir = $direction;
				$humanChr = $chrNum;
				###
				$humanSeq = $nuc;
				$humanLen = $length;
				$humanActualLen = length($nuc);
				$humanStart = $startPos;
			}

	
			my $endPosition = $startPos + $length-1;
#			print "Species: ".$speciesName."\n"; 
#			print "CHR:".$chrNum."\n";
#			print "length:".$length."\n";
#			print "lengthCheck:".length($nuc)."\n";
#			print "Start Position: $startPos";
#			print "End Postion: $endPosition";
#			print "Nuc:".$nuc."\n";
			#Initialize I
			my $i = 0;
			my $pos= $startPos+1;	
			
			my $humanPos = $humanStart +1;

		   my $lenOfSeq = length($nuc);
			# Loop to output the nuc into the appropiate Nucleotide file for the appropriate species
			while ($i < $lenOfSeq)
			## LEN OF SEQ SHOULD BE THE SAME FOR HUMAN AND ANIMLAL
			{
			
			 my $currentNuc = substr($nuc,$i,1);
			 my $currentHumanNuc = substr($humanSeq,$i,1);
			 
				## DEVELOPER TEST
				if (($i+1) == $lenOfSeq)
				{
					if (($pos)== $endPosition)
					{
	#					print "Position Pass\n";
			
					}
					## Situation when the pos ends but ++ and not end of Sequence ------
					## So if its AAAC- and the final positon is a -, then check if Pos-1 is the end positon 
					elsif($currentNuc eq "-" && ($pos-1) == $endPosition)
					{
		#				print "Position pass\n";
					
					}
					else
					{
			#			print "Position Fail\n"
						print ERROR "Position Failed $species $startPos";
					}
				}
				
				
				##http://www.nntp.perl.org/group/perl.beginners/2009/02/msg106178.html
				##OUTPUT HUMAN INFO
				my $humanOut;
				if ($currentHumanNuc =~ "-")
				{
			
					$humanOut = "$humanChr x - -";
				}
				else
				{
					$humanOut = $humanChr." ".$humanDir." ".$humanPos." ".$currentHumanNuc;
				$humanPos ++;

				}
				
					
					
			if ($humanOut ne "-")
			{		

				## OUTPUT FOR CURRENT SPECIES
				
				my $fName = $speciesName . "file";
			

				#If the Species Nucleotide is currently Unknown. 
				if ($currentNuc =~ "-")
				{
				
					no strict 'refs';
					## REMOVED ${fName} FOR TESTING
					
					print $fName $humanOut." "."$chrNum x - $currentNuc\n"; 
				#		print $humanOut." "."POSITION"." "."-"."\n";
					$i++;
					## DONT INCREASE I
				}
				else
				{
					no strict 'refs';
					print $fName $humanOut." "."$chrNum $direction $pos $currentNuc\n"; 
				#	print $humanOut." ".$pos." ".$currentNuc."\n";
					$pos ++;
					$i++;
				}
			}
			else
			{
				$i++;

			}
			#####TO DO:
################
### DATA CHECKS
### CHECK THE LENGTH OF THE SEQUENCE
### CHECK THAT THE SIZE OF THE ORG SEQENCE MAKE SURE ITS SAME AS HUMAN
### OUTPUT: output all Errors (size not match, etc)

				
				
#####################
				
				
		}## End of while Loop iterating through the sequence


	}#End of pattern match Begining S
		
	


	
}## End of While loop for file
	close (FLE);
	
	for my $file  (keys %species)
	{
		my $fileName = $file . "file";
		
		close($fileName);

	}	
	






