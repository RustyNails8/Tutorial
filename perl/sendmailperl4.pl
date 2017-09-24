#!/usr/bin/perl


my $file = "$1";
my $message = do {
    local $/ = undef;
    open my $fh, "<", $file
        or die "could not open $file: $!";
    <$fh>;
};
$to = '$2';
$from = 'AIX-Monitoring';
$subject = '$1';
open(MAIL, "|/usr/sbin/sendmail -t");
# Email Header
print MAIL "To: $to\n";
print MAIL "From: $from\n";
print MAIL "Subject: $subject\n\n";
# Email Body
print MAIL $message;
close(MAIL);
print "Email Sent Successfully\n";



