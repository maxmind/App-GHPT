#!/usr/bin/perl

# See configure-submit-work.sh if you have trouble running this script.

use mmperl;

use FindBin qw($Bin);
use lib "$Bin/../../lib", "$Bin/../../../lib";

use App::SubmitWork::WorkSubmitter;

exit App::SubmitWork::WorkSubmitter->new_with_options->run;

__END__

=head1 NAME

submit-work.pl

=head1 SYNOPSIS

   $ submit-work.pl

=head1 DESCRIPTION

Making pull requests simpler

=head1 SETUP

=head2 hub

You should first set up C<hub>.

It's available at L<https://hub.github.com> and has installation instructions there.

After installation, tell git config about it and check that it's working.

    git config --global --add hub.host github.com
    hub issue

(You'll need your GitHub / GHE credentials.)

=head2 pt config

You'll also need to tell git about your PT account:

    git config --global submit-work.pivotaltracker.username thor
    git config --global submit-work.pivotaltracker.token ae158fa0dc6570c8403f04bd35738d81

(Your actual token can be found at L<https://www.pivotaltracker.com/profile>)

=head1 TROUBLESHOOTING

=head2 Bad Credentials

When hub is first used to connect to GitHub/GitHub Enterprise, hub requires a
name and password that it uses to generate an OAUTH token and stores it in
C<~/.config/hub>. If you have not used hub yet, this script will exit with:

    $ submit-work.pl --project minf
    Error creating pull request: Unauthorized (HTTP 401)
    Bad credentials

The fix is to regenerate the OAUTH token. Delete the C<~/.config/hub> file if
you've got one, and then run a C<hub> command manually, such as
C<hub browse>. After authenticating, you should be able to use this script.

=head1 BUGS

This requires 'hub' to be installed and configured.

A fatal error may occur if your branch exists locally, but you haven't pushed it yet.

You may also get a warning like below, but this shouldn't impact the creation of your pull request.

    Content-Length header value was wrong, fixed at /opt/perl5.20.2/lib/site_perl/5.20.2/LWP/Protocol/http.pm line 258, <> line 1.

=cut
