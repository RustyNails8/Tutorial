#!/usr/sap/toolbox/bin/perl -I/home/pacadm/soft/perl5/site_perl/5.8.8
############################################################################
## Sumit Das 2015 06 07
## Adapted from Dieter Dorra
############################################################################
use Mail::Sender;
 
$sender = new Mail::Sender
(
    {
	from => 'pacadm@sap-appcom.t-ystems.com',
	smtp => 'smtpeu.linde.grp'
     }
);

$sender->MailFile
(
  {
	to =>'sam8boc@gmail.com',
	subject => 'attachment test',
	msg => "test body", 
  	file => '/home/pacadm/scripts/data/all_vlans.txt'
  }
);

print "done.";

