# NAME

App::SubmitWork - create a pull request for a Pivotal Tracker ticket

# DESCRIPTION

This is currently a pre-release version of some internal MaxMind code that we
use to create a pull request for a given PT story.  Running this command line
tool from withing a git repo allows you to interactively pick a started PT
ticket for a given project and create a pull request between the current branch
and master (or another branch.)  It'll ask you what text to put in the branch
(using the contents of the PT ticket by default) and you can even setup
questions it should ask and put the answers in the pull request based on what
files are being changed and what they contain.  Finally it'll leave a comment on
the PT ticket linking it to the pull request and mark the ticket as finished.

At this point it's really for informational purposes only (though it all works.)
It does things that aren't really suitable for public reuse including needing
a very recent version of perl, and enabling experimental Perl features.  YMMV.

# AUTHOR

Mark Fowler <mfowler@maxmind.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by MaxMind, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
