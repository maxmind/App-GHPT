#!/usr/bin/env perl

use App::SubmitWork::Wrapper::Ourperl;

use FindBin qw($Bin);
use lib "$Bin/../../lib", "$Bin/../../../lib";

use App::SubmitWork::WorkSubmitter;

exit App::SubmitWork::WorkSubmitter->new_with_options->run;

__END__

=head1 DESCRIPTION

See L<App::SubmitWork> for details on how to configure this program.
