requires "File::HomeDir" => "0";
requires "FindBin" => "0";
requires "IPC::Run3" => "0";
requires "Import::Into" => "0";
requires "Lingua::EN::Inflect" => "0";
requires "List::AllUtils" => "0";
requires "List::Gather" => "0";
requires "List::Util" => "0";
requires "Module::Pluggable::Object" => "0";
requires "Moose" => "0";
requires "Moose::Exporter" => "0";
requires "Moose::Role" => "0";
requires "Moose::Util" => "0";
requires "MooseX::Getopt::Dashes" => "0";
requires "MooseX::Role::Parameterized" => "0";
requires "MooseX::Role::Parameterized::Meta::Trait::Parameterizable" => "0";
requires "MooseX::SemiAffordanceAccessor" => "0";
requires "MooseX::StrictConstructor" => "0";
requires "MooseX::Types::Combine" => "0";
requires "Path::Class" => "0";
requires "Term::Choose" => "0";
requires "Term::EditorEdit" => "0";
requires "WebService::PivotalTracker" => "0.04";
requires "autodie" => "2.25";
requires "experimental" => "0";
requires "feature" => "0";
requires "indirect" => "0";
requires "lib" => "0";
requires "mro" => "0";
requires "multidimensional" => "0";
requires "namespace::autoclean" => "0";
requires "open" => "0";
requires "parent" => "0";
requires "strict" => "0";
requires "utf8" => "0";
requires "warnings" => "0";

on 'test' => sub {
  requires "ExtUtils::MakeMaker" => "0";
  requires "File::Spec" => "0";
  requires "Hash::Objectify" => "0";
  requires "Test::Class::Moose" => "0";
  requires "Test::Class::Moose::AttributeRegistry" => "0";
  requires "Test::Class::Moose::Load" => "0";
  requires "Test::Class::Moose::Runner" => "0";
  requires "Test::Differences" => "0";
  requires "Test::More" => "0.96";
  requires "Test::Output" => "0";
};

on 'test' => sub {
  recommends "CPAN::Meta" => "2.120900";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

on 'develop' => sub {
  requires "Code::TidyAll::Plugin::Test::Vars" => "0.02";
  requires "File::Spec" => "0";
  requires "IO::Handle" => "0";
  requires "IPC::Open3" => "0";
  requires "Parallel::ForkManager" => "1.19";
  requires "Perl::Critic" => "1.126";
  requires "Perl::Tidy" => "20160302";
  requires "Pod::Coverage::TrustPod" => "0";
  requires "Pod::Wordlist" => "0";
  requires "Test::CPAN::Changes" => "0.19";
  requires "Test::CPAN::Meta::JSON" => "0.16";
  requires "Test::CleanNamespaces" => "0.15";
  requires "Test::Code::TidyAll" => "0.50";
  requires "Test::EOL" => "0";
  requires "Test::Mojibake" => "0";
  requires "Test::More" => "0.96";
  requires "Test::NoTabs" => "0";
  requires "Test::Pod" => "1.41";
  requires "Test::Pod::Coverage" => "1.08";
  requires "Test::Portability::Files" => "0";
  requires "Test::Spelling" => "0.12";
  requires "Test::Synopsis" => "0";
  requires "Test::Vars" => "0.009";
  requires "Test::Version" => "2.05";
  requires "blib" => "1.01";
  requires "perl" => "5.006";
};
