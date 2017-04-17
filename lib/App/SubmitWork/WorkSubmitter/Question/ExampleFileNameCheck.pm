package App::SubmitWork::WorkSubmitter::Question::ExampleFileNameCheck;

# ABSTRACT: Confirm the DB migration will run before or after backend updates

use App::SubmitWork::Wrapper::OurMoose;

use List::Gather qw( gather take );

with(
    'App::SubmitWork::WorkSubmitter::Role::Question'
);

sub ask($self) {
    # must return an array of text to insert in the pull request description
    return gather {
        for my $file (
            'should/not/be/changed',
            'do/not/touch',
            'abandon/hope/all/who/edit/this/file',
            'badfile',
        ) {
            next unless $self->changed_files->file_exists( $file );

            # if our class had consumed the
            # App::SubmitWork::WorkSubmitter::Role::FileInspector role we could
            # use $self->file_contents( $file ) to see what was in the file
            # staged for commit in the staging area (opposed to the what's in
            # the working directory which may be different) but that's slow, so
            # we're not doing that in this example

            # ask the question, provide the default answers which the user
            # can select from, or the last option which is "Launch Editor"
            # so they can give an arbitary answer
            take $self->ask_question(
                <<"ENDOFQUESTION",
file $file really should not be changed unless you've got
a really really really good reason.

What's your reason?
ENDOFQUESTION
                q{No good reason, but PHB told me to do this so here we are},
                q{I have my reasons, but I can't tell them to you},
            );
        }
    };
}

__PACKAGE__->meta->make_immutable;
1;

