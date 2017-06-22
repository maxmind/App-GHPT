package App::GHPT::WorkSubmitter::Role::FileInspector;

use App::GHPT::Wrapper::OurMoose::Role;

our $VERSION = '1.000006';

use IPC::Run3 qw( run3 );

sub file_contents ( $self, $path ) {
    state %cache;
    return $cache{$path} if exists $cache{$path};

    my @command = (
        'git',
        'show',
        "HEAD:$path",
    );

    run3 \@command, \undef, \my $output, \my $error;
    if ( $error || $? ) {
        die join q{ }, 'Problem running git show', @command, $error, $?;
    }

    $cache{$path} = $output;

    return $output;
}

1;

# ABSTRACT: Role for examining the committed version of the file
