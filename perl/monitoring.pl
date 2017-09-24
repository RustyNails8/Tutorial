#!/usr/bin/perl
# Sumit Das 2015 06 10
use warnings;
use strict;

open(FH, '>', 'moniLISTtoday') or die "cannot open file";
select FH;

my %MONI=(
        Abhijit 	=> 	[ 'VP4', 'P8B', ],  
		Ali 		=> 	[ 'NULL', ], 	
		Alok 		=> 	[ 'NULL', ],  
		Ashok 		=> 	[ 'NULL', ],  
		Avik 		=> 	[ 'GPA', 'GPE', ],
		Christer	=> 	[ 'NULL', ],  	
		Deepjyoti	=> 	[ 'P6E', 'P1B', 'VP1', ],	
		Gaurav 		=> 	[ 'PGH', 'GPC', ],
		Kishore 	=> 	[ 'P9B', 'GPB', ], 
		Saikat 		=> 	[ 'GPR', 'P2E', ],
		Sanjay 		=> 	[ 'ZP2', 'P9E', ],
		Santanu 	=> 	[ 'NULL', ],
		Santosh 	=> 	[ 'PGX', 'LPR', ], 
		Seshagiri	=> 	[ 'NULL', ],  	
		Simon 		=> 	[ 'NULL', ],  
		Subhasis	=> 	[ 'BWP', 'PCB', 'CRP', ],
		Sudipta		=> 	[ 'P01', 'PNU', 'PRD', ],
		Sumit 		=> 	[ 'GPF', 'P7E', ],
		Tushar 		=> 	[ 'P8E', 'GPL', 'PXI', ],
);

foreach my $group (keys %MONI) {
    print "$group will today monitor	\n";
    foreach (@{$MONI{$group}}) {
        print "\t$_\n";
    }
}

close FH;

open(FH1, '>', 'moniAUTOperlLOG') or die "cannot open file";
select FH1;

foreach my $group (keys %MONI) {
    print "$group Log File	\n";
    foreach (@{$MONI{$group}}) {
        print "\t$_\n";
		system("more /home/users/in10c2/sumit/ALL-LPAR-List | grep $_ >> moniAUTOperlLOG");

    }
}


close FH1;