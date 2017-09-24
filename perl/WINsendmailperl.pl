#!/usr/bin/perl
use MIME::Lite;
 
$to = 'sam8boc@gmail.com';
$cc = 'sam8ibm@mail.com';
$from = 'DIMPerl';
$subject = 'Test Email';
$message = 'This is test email sent by Perl Scripton WIN 7';

$msg = MIME::Lite->new(
                 From     => $from,
                 To       => $to,
                 Cc       => $cc,
                 Subject  => $subject,
                 Data     => $message
                 );
                 
$msg->send;
print "Email Sent Successfully\n";