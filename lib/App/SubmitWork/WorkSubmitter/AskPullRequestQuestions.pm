package App::SubmitWork::WorkSubmitter::AskPullRequestQuestions;

use App::SubmitWork::Wrapper::OurMoose;

# ABSTRACT: Ask questions to go in the pull request

use App::SubmitWork::Types qw( ArrayRef Str );
use Module::Pluggable::Object;
use App::SubmitWork::WorkSubmitter::ChangedFilesFactory;

=head1 SYNOPSIS

   my $markdown = App::SubmitWork::WorkSubmitter::AskPullRequestQuestions->new(
        merge_to_branch_name => 'master',
   )->ask_questions;

=head1 DESCRIPTION

A module to ask questions about the branch you're creating a pull request
about and find.

This module searches for all C<App::SubmitWork::WorkSubmitter::Question::*> modules and uses
them to produce markdown.

=head1 ATTRIBUTES

=head2 merge_to_branch_name

The name of the branch that we're creating the pull request against.  This is
probably C<master>.

Required. Str.

=cut

has merge_to_branch_name => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has _changed_files => (
    is      => 'ro',
    isa     => 'App::SubmitWork::WorkSubmitter::ChangedFiles',
    lazy    => 1,
    builder => '_build_changed_files',
);

sub _build_changed_files ($self) {
    return App::SubmitWork::WorkSubmitter::ChangedFilesFactory->new(
        merge_to_branch_name => $self->merge_to_branch_name,
    )->changed_files;
}

has _questions => (
    is      => 'ro',
    isa     => ArrayRef,
    lazy    => 1,
    builder => '_build_questions',
);

sub _build_questions ($self) {
    return [
        map { $_->new( changed_files => $self->_changed_files ) }
            Module::Pluggable::Object->new(
            search_path => 'App::SubmitWork::WorkSubmitter::Question',
            require     => 1,
            )->plugins,
    ];
}

=head1 METHODS

=head2 $asker->ask_questions

Ask all the questions, return markdown.

=cut

sub ask_questions ($self) {
    return join "\n", map { $_->ask } $self->_questions->@*;
}

__PACKAGE__->meta->make_immutable;
1;
