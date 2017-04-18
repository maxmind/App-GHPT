package App::SubmitWork;

our $VERSION = '1.000000';

1;

__END__

=head1 NAME

App::SubmitWork

=head1 DESCRIPTION

This is a commmand line tool to help link together
L<GitHub|https://github.com/> and L<Pivotal
Tracker|https://www.pivotaltracker.com/>. It helps enable a workflow combining
PT stories with pull requests.

The basic workflow is as follows:

=over 4

=item 1.

Start a story in Pivotal Tracker.

=item 2.

Hack, hack, hack.

=item 3.

Run this tool, which will do the following things for you:

=over 8

=item *

Prompt you to select one of your active Pivotal Tracker stories.

=item *

(Optional)

Ask you a set of questions about the work you've done. The answers are
included in your PR. The question generation can be customized by writing
plugins.

=item *

Create a pull request on GitHub for the repo you are currently in, with the PT
story's title, URL, and description in the PR, a well as the optional
questions & answers.

=item *

Add a comment on the PT story linking to the PR that was just created.

=item *

Change the PT story's status to "Delivered".

=back

=back


