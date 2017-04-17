package App::SubmitWork::WorkSubmitter::Role::HasPT;

use App::SubmitWork::Wrapper::OurMoose::Role;

use WebService::PivotalTracker 0.04;

requires '_pt_token';

has _pt_api => (
    is      => 'ro',
    isa     => 'WebService::PivotalTracker',
    lazy    => 1,
    builder => '_build_pt_api',
    documentation =>
        'A WebService::PivotalTracker object built using $self->_pt_token',
);

sub _build_pt_api ($self) {
    return WebService::PivotalTracker->new(
        token => $self->_pt_token,
    );
}

1;
