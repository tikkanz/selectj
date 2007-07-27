AnimalSim EBV multitrait evaluation   --- Ric Sherlock & Nicolas Lopez-Villalobos -----------
 flk   3     !I
 yob    9    !I
 Tag         !A !P
 sflk   3    !I
 syob   9    !I
 sire        
 dflk   3    !I
 dyob   9    !I
 dam         
 sex    2    !I
 aod    7    !I 
 br     4    !I    
 rr     4    !I
 dob
 status
 LW8                     #predictor trait
 FD                      #predictor trait
 LEAN        !=-1 !M -1  #create correlated trait with no phenotype
 FAT         !=-1 !M -1  #create correlated trait with no phenotype

multivarped.txt !SKIP 1 !MAKE !ALPHA 
multivar.csv !SKIP 1 !MAXIT 1

                   # *** Multiple Trait Analysis ******
LW8 FD LEAN FAT ~Trait at(Trait,1).flk.yob at(Trait,1).br at(Trait,1).aod at(Trait,1).sex at(Trait,1).dob,
                       at(Trait,2).flk.yob at(Trait,2).br at(Trait,2).aod at(Trait,2).sex at(Trait,2).dob,
                       at(Trait,3).flk.yob at(Trait,3).br at(Trait,3).aod at(Trait,3).sex at(Trait,3).dob,
                       at(Trait,4).flk.yob at(Trait,4).br at(Trait,4).aod at(Trait,4).sex at(Trait,4).dob,
                       !r Trait.Tag

1 2 1 !STEP 0.01            
#residuals
0                                              
Trait 0 US 8.94 !+9
           1.59 0.99
           2.15 0.39 0.62
           1.6 0.44 0.41 0.4

Trait.Tag 2                 
Trait 0 US  3.31 !+9
            0.42 0.33
            0.9 0.03 0.36
            0.51 0.2 0.07 0.2
            
Tag
