
# It is valid for an HTTP header to span multiple lines, as long as the continuation lines start with
# at least one space. This should be taken into account when parsing headers. 

use Test::More 'no_plan';
use CGI::Application::Emulate::PSGI;
use CGI::Application;

{
    my $psgi_app = CGI::Application::Emulate::PSGI->handler(sub {
            my $webapp = CGI::Application->new;
            $webapp->header_add( -zoo => "single-line header" );
            $webapp->run();
        });

    my ($out) = $psgi_app->(\%ENV);
    my ($status,$headers) = @$out;

    is($status,200, "got 200 status");
    is($headers->[0], "Zoo", "first header name is Zoo");
    like($headers->[1], qr{single}, "first header value matches 'single'");
    is($headers->[2], "Content-Type", "second header name is Content-Type");
    like($headers->[3], qr{text/html}, "header header value matches text/html");
}
{
    my $psgi_app = CGI::Application::Emulate::PSGI->handler(sub {
            my $webapp = CGI::Application->new;
            $webapp->header_add( -foo => "multi-line: header\n fools: you?" );
            $webapp->run();
        });

    my ($out) = $psgi_app->(\%ENV);
    my ($status,$headers) = @$out;

    is($status,200, "got 200 status");
    is($headers->[0], "Foo", "first header name is Foo");
    like($headers->[1], qr{fools: Your}, "first header value matches 'fools: you'");
    is($headers->[2], "Content-Type", "second header name is Content-Type");
    like($headers->[3], qr{text/html}, "header header value matches text/html");
}





