package App::SubmitWork::Types;

use App::SubmitWork::Wrapper::Ourperl;

our $VERSION = '1.000000';

use parent 'MooseX::Types::Combine';

use MooseX::Types::Common::Numeric ();
use MooseX::Types::Moose           ();

__PACKAGE__->provide_types_from(
    qw(
        MooseX::Types::Common::Numeric
        MooseX::Types::Moose
        )
);

1;
