package TestFor::App::GHPT::WorkSubmitter::AskPullRequestQuestions;

use App::GHPT::Wrapper::OurTest::Class::Moose;

use App::GHPT::WorkSubmitter::AskPullRequestQuestions ();

sub test_question_namespaces {
    local @INC = ( @INC, 't/lib' );

    my $ask = App::GHPT::WorkSubmitter::AskPullRequestQuestions->new(
        merge_to_branch_name => 'master',
        question_namespaces  => ['Helper::QuestionNamespace1'],
    );

    is_deeply(
        [ sort map { ref($_) } $ask->_questions->@* ],
        ['Helper::QuestionNamespace1::Question'],
        'asker only looks in namespace it is given'
    );

    $ask = App::GHPT::WorkSubmitter::AskPullRequestQuestions->new(
        merge_to_branch_name => 'master',
        question_namespaces =>
            [ 'Helper::QuestionNamespace1', 'Helper::QuestionNamespace2' ],
    );

    is_deeply(
        [ sort map { ref($_) } $ask->_questions->@* ],
        [
            'Helper::QuestionNamespace1::Question',
            'Helper::QuestionNamespace2::Question'
        ],
        'asker can find questions in multiple namespaces'
    );
}

__PACKAGE__->meta->make_immutable;
1;
