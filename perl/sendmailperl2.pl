#!/usr/bin/perl

#my $file = "moni-server-v.2.1.sh.bkp";
my $file = $1;
my $message = do {
    local $/ = undef;
    open my $fh, "<", $file
        or die "could not open $file: $!";
    <$fh>;
};
print $file;
print $message;


#$to = 'sam8boc@gmail.com';
$to = $2;
$from = 'AIX Monitoring';
$subject = $1;
#$message = cat moni-server-v.2.1.sh.bkp

#open(FILE, 'moni-server-v.2.1.sh.bkp') or die "Can't read file 'filename' [$!]\n";
#$message = <FILE>;
#close (FILE);
#print $message;

open(MAIL, "|/usr/sbin/sendmail -t");

# Email Header
print MAIL "To: $to\n";
print MAIL "From: $from\n";
print MAIL "Subject: $subject\n\n";
# Email Body
print MAIL $message;

close(MAIL);
print "Email Sent Successfully\n";


