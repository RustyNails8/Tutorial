# WARNING - as of SAP::Rfc 1.40 USER and PASSWD are case sensitive ready for 
# R3 7.x
  use SAP::Rfc;
  $rfc = new SAP::Rfc(
                    ASHOST   => 'myhost',
                    USER     => 'ME',
                    PASSWD   => 'secret',
                    LANG     => 'EN',
                    CLIENT   => '200',
                    SYSNR    => '00',
                    TRACE    => '1' );
 
my $it = $rfc->discover("RFC_READ_TABLE");
 
$it->QUERY_TABLE('TRDIR');
$it->ROWCOUNT( 2000 );
$it->OPTIONS( ["NAME LIKE 'RS%'"] );
 
# or pass a list of hash refs like so:
$it->OPTIONS( [ { TEXT => "NAME LIKE 'RS%'" } ] );
 
$rfc->callrfc( $it );
 
print "NO. PROGS: ".$it->tab('DATA')->rowCount()." \n";
print join("\n",( $it->DATA ));
 
$rfc->close();