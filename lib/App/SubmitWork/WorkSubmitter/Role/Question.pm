package App::SubmitWork::WorkSubmitter::Role::Question;

# ASBTRACT: Role for writing interactive questions about the commits

use App::SubmitWork::Wrapper::OurMoose::Role;

use Term::Choose qw( choose );
use Term::EditorEdit;

requires 'ask';

=head1 SYNOPSIS

    package App::SubmitWork::WorkSubitter::Question::WarnAboutPasswordFile;
    use App::SubmitWork::Wrapper::OurMoose;
    with 'App::SubmitWork::WorkSubmitter::Role::Question';

    sub ask($self) {
        # skip the question unless there's a password file
        return unless $self->changed_files->changed_files_match(qr/password/);

        # ask the user if that's okay
        return $self->ask_question(<<'ENDOFTEXT',"I'm okay with the risk");
    You've committed a file with a name matching 'password'.  Are you nuts?
    ENDOFTEXT
    }

    __PACKAGE__->meta->make_immutable;
    1;

=head1 DESCRIPTION

This role allows you to write questions to ask someone when creating pull
request.

You want to create these questions classes in the
C<App::SubmitWork::WorkSubmitter::Question::*> namespace where
L<App::SubmitWork::WorkSubmitter::Questioner> will automatically detect them and ask them
each time submit-work is run.

Each class must supply an C<ask> method which should prompt the user as needed
and return any markdown to be placed in the pull request body.

=attribute changed_files

The files that have changed in this branch.  This is the primary attribute
you want to examine.

=cut

has changed_files => (
    is       => 'ro',
    isa      => 'App::SubmitWork::WorkSubmitter::ChangedFiles',
    required => 1,
);

=method ask_question($question, @optional_responses)

Interatively ask a question and return markdown suitable for including in the
pull request body.

The question that should be asked must be passed as the first arguement, and
all other arguments are treated as stock answers the user can select when
asked the question.  The user will also have a final option C<Launch Editor>
which will launch their editor and allow them free-form text input.

=cut 

sub ask_question ( $self, $question, @responses ) {
    my $choice = choose(
        [
            @responses,
            'Launch Editor'
        ],
        { prompt => $question }
    ) or exit;    # user hit 'q' or ctrl-d to stop

    return $self->format_qa_markdown( $question, $choice )
        unless $choice eq 'Launch Editor';

    # todo: It would be nice if the notes persisted to disk for a given PT so
    # that I could ctrl-c out of a later question and still not have to retype
    # previously asked questions.  That's a task for another day however.
    my $answer = Term::EditorEdit->edit(
        separator => '---',
        document  => <<"ENDOFTEXT",
$question

Complete your answer below the line in markdown.
---
ENDOFTEXT
    );

    return $self->format_qa_markdown( $question, $answer );
}

sub _trim ($text) {
    return $text =~ s/\A\s+//r =~ s/\s+\z//r;
}

sub format_qa_markdown ( $self, $question, $answer ) {
    return <<"ENDOFMARKDOWN"
### Question ###
@{[ _trim( $question )]}

### Answer ###
@{[ _trim( $answer ) ]}
ENDOFMARKDOWN
}

1;
