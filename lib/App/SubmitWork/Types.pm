package App::SubmitWork::Types;

use App::SubmitWork::Wrapper::Ourperl;

our $VERSION = '1.000000';

use parent 'MooseX::Types::Combine';

__PACKAGE__->provide_types_from(
    qw(
        MooseX::Types::Common::Numeric
        MooseX::Types::Moose
        )
);

1;
