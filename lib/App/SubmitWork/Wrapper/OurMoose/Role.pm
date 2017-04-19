package App::SubmitWork::Wrapper::OurMoose::Role;

use App::SubmitWork::Wrapper::Ourperl;

our $VERSION = '1.000000';

use Import::Into;
use Moose::Exporter;
use Moose::Role                    ();
use MooseX::SemiAffordanceAccessor ();
use namespace::autoclean           ();

my ($import) = Moose::Exporter->setup_import_methods(
    install => [ 'unimport', 'init_meta' ],
    also    => ['Moose::Role'],
);

sub import {
    my $for_role = caller();

    $import->( undef, { into => $for_role } );
    MooseX::SemiAffordanceAccessor->import( { into => $for_role } );

    my $caller_level = 1;
    App::SubmitWork::Wrapper::Ourperl->import::into($caller_level);
    namespace::autoclean->import::into($caller_level);
}

1;
