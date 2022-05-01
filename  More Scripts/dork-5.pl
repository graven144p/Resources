use FEAR::API -base;
url("metacpan.org");
fetch >> [
    qr(foo) => _feedback,
    qr(bar) => \my @link,
    qr()    => sub { 'do something here' }
];
fetch while has_more_links;
extmethod('Template::Extract');
extract($template);
print Dumper extresult;
print document->as_string;
print Dumper \@link;
invoke_handler('YAML');
