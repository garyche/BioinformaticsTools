#!/bin/python

import sys;

inputFile = sys.argv[1];
inputFile2 = sys.argv[2];
## DEV TEST
#print inputFile;

hg19Dict = {}

f = open(inputFile, 'r');


count = 0;
#print "Reading and outputting the line"
for line in f:
    line = line.strip()
    cord,nuc = line.split()
    
    hg19Dict[cord] = nuc;
    #count = count+1;
f.close()

#print hg19Dict

### Note that the lines need to be sorted


f2 = open(inputFile2, 'r');


#print "Outputting File 2 Test:"

## Open file
# read line by line
## sort the dict
## if the cord in the first item in the dict is lower, go through untill reach the current
count = 59995; 
#print "hg19 59995:",hg19Dict['59995']
currentHCord = 0;
for line in f2:
    line= line.strip()
    hChr,hDir,hCord,hNuc,chr,dir,cord,nuc = line.split()
    currentHCord = int(hCord);
    
  #  print "Count: ",count
 #   print "hCord: ",hCord
    
    


    while (int(hCord) > count):
        print count," ",hg19Dict[str(count)]," Less Than "
        count = count +1
        
    if (int(hCord) == count):
        print line," Equal to"
        count = count +1
        continue;
        
    if (count > int(hCord)):
        print hg19Dict[count]
        count = count + 1
        continue
    
#print "Final Cord: ",currentHCord
#print "Final Count:",count

largestKey = max(hg19Dict.keys(), key=int)
while (count <= int(largestKey)):
    print count," ",hg19Dict[str(count)]
    count = count +1
   
    
        

    
#print "Ouputting the arary";
#for items in array:
 #   print items
    
    

#print "first Item: " + array[0]


## SKIP ##
#Sort the hash (skip step if array of array)


    




##


#for line in f2:
    ## PARSE NUCLEOTIDE
#    line = line.strip()
    
   # data = line.split(" ");
    
    
	# Merge Algorithm (Merging a sorted list with a sorted list stored on memory)
	
	
	## Compare current line to the Array
	## If Array is less, pop and print array untill the length is reached
	## If Array key = Nucleotide coordinate, Print nuc coord
	## If Array Key > Nuc cord, move to the next coord and do the same evaluation.
    
 #   if (nucleotideParsed > line):
#        line = f2.readLine();
        
 #   elif (nucParesd = line):
  #      Do this stuff
        
    
  #  else
    
   #     Move to the next nucleotide

## CLOSE FILE


    
        
        
        ### PARSE LINE 
        


	
	



