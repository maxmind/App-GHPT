package App::GHPT::WorkSubmitter::AskPullRequestQuestions;

use App::GHPT::Wrapper::OurMoose;

our $VERSION = '2.000000';

use App::GHPT::Types                              qw( ArrayRef Str );
use Module::Pluggable::Object                     ();
use App::GHPT::WorkSubmitter::ChangedFilesFactory ();

has merge_to_branch_name => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has question_namespaces => (
    is       => 'ro',
    isa      => ArrayRef [Str],
    required => 1,
);

has _changed_files => (
    is      => 'ro',
    isa     => 'App::GHPT::WorkSubmitter::ChangedFiles',
    lazy    => 1,
    builder => '_build_changed_files',
);

sub _build_changed_files ($self) {
    return App::GHPT::WorkSubmitter::ChangedFilesFactory->new(
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
            search_path => $self->question_namespaces,
            require     => 1,
        )->plugins,
    ];
}

sub ask_questions ($self) {
    return join "\n", map { $_->ask } $self->_questions->@*;
}

__PACKAGE__->meta->make_immutable;

1;

# ABSTRACT: Ask questions to go in the pull request

__END__

=pod

=head1 SYNOPSIS

   my $markdown = App::GHPT::WorkSubmitter::AskPullRequestQuestions->new(
        merge_to_branch_name => 'main',
   )->ask_questions;

=head1 DESCRIPTION

A module to ask questions about the branch you're creating a pull request
about and find.

This module searches for all C<App::GHPT::WorkSubmitter::Question::*> modules and uses
them to produce markdown.

=head1 ATTRIBUTES

=head2 merge_to_branch_name

The name of the branch that we're creating the pull request against.  This is
probably C<main>.

Required. Str.

=head1 METHODS

=head2 $asker->ask_questions

Ask all the questions, return markdown.

=cut
