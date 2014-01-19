#!/usrs/bin/perl

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

## OPEN THE RESPECTIVE FILES;

for my $file  (keys %species)
{
	no strict 'refs';
    #	print "FILE IS $file\n";
	my $fileName = $file . "file";
    
    #	print "Filename = $fileName\n";
	open($file,">",$fileName) or die "Sorry cant open $file";
    
}


$in = $ARGV[0];
open (FLE, $in);

while (<FLE>)
{
	
	
	if ($_ =~ />/)
	{
        #print $_;
        
        @header1 = split('_',$_);
        #print  " $out[2] \n";
        $species = $header1[2];
        
        @header2 = split(/\s+/,$_);
        
        my $chr;
        my $start;
        my $end;
        my $strand;
        my $position;
        
        if (exists $header2[4])
        {
            
            print $header2[4]."\n";
            
            $coordinates = $header2[4];
            ($chr, $coord) = split(/\:/,$coordinates);
            
            
            ($start, $end) = split ("-",$coord);
            if ($end =~ m/\w+\+/)
            {
                $strand = "+";
                $position = $start;
                
                
            }
            else
            {
                $strand = "-";
                $position = $end;
                
            }
            
            
        }
        else
        {
            $strand = "x";
            $chr = "-";
            $postion = "-";
        }
        
        
        
        
        
        
        my $length = $header2[1];
        
        
        
        
        #print "$chr $start $end \n";
        
        
        ### THIS PRINTS OUT THE HEADER DATA
        if (exists $header2[4])
        {
            #		print "$species $chr $start $end \n";
        }
        else
        {
            #		print "$species $chr - -\n";
            
        }
        
        
        
        
        
        $nextLine = <FLE>;
        #print $nextLine;
        
        
        #print "$nextLine \n";
        #print "$length\n";
        
        
        # print "$position \n";
        my $i= 0;
        while ($i < $length)
        {
            my $nuc = substr($nextLine,$i,1);
            if ($nuc =~ "-")
            {
				print $species "$species $chr $nuc - $strand\n";
				$i ++;
            }
            else
            {
                print $species "$species $chr $nuc $position $strand\n";	
                if ($strand eq "+")
                {
                    $position = $position+1;
                }	
                elsif ($strand eq "-")
                {
                    $position = $position -1;
                }
                
                
                $i ++;
            }
            
        }
        
        
        
    }
	
    
    
	
}	$positive = 0;
	if ($end =~ m/\w+\+/)
	{
		$positive = 1;
		#print "Positive Strand: $coordinates $positive\n";
		
	}
	
	#print "$chr $start $end \n";  
	
	
	### THIS PRINTS OUT THE HEADER DATA
	if (exists $header2[4])
	{
#		print "$species $chr $start $end \n";
	}
	else
	{
#		print "$species $chr - -\n";
		
	}
	
	
	
	
	
	$nextLine = <FLE>;
	#print $nextLine;
	
	
	#print "$nextLine \n";
	#print "$length\n";
	my $position;
	
	if (exists $header2[4])
	{	
		$position = $start;
		
	}
	else
	{
		$postion = "-";
	}
	
 # print "$position \n";
	my $i= 0;
	while ($i < $length)
	{
		my $nuc = substr($nextLine,$i,1);
		if ($nuc =~ "-")
		{
				print $species "$species $chr $nuc -\n";
				$i ++;
		}
		else
		{
			print $species "$species $chr $nuc $position\n";	
			if ($position =~ m/\d+/)
			{
				$position ++;
			}	
			$i ++;
		}
	
	}
	
	
	
}
	

	
	
	
}