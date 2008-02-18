use strict;
use warnings;

package App::Addex::Plugin::Hiveminder;
use Sub::Install;

my $done = 0;

sub import {
  my ($self, %arg) = @_;
  die "no 'secret' config value for $self" unless %arg and $arg{secret};
  $arg{todo_label} ||= 'todo';

  return if $done;

  require App::Addex::Entry;
  my $original_sub = App::Addex::Entry->can('emails');

  my $new_emails = sub {
    my ($self) = @_;

    my @emails = $self->$original_sub;

    return @emails if grep { $_->label eq $arg{todo_label} } @emails;

    my $todo_label = $self->field('todos_to');
    my ($email) = grep { $_->label eq $todo_label } @emails;
    $email ||= $emails[0];
    
    push @emails, App::Addex::Entry::EmailAddress->new({
      address => $emails[0]->address . ".$arg{secret}.with.hm",
      label   => $arg{todo_label},
      sends   => 0,
    });
    
    return @emails;
  };

  Sub::Install::reinstall_sub({
    code => $new_emails,
    into => 'App::Addex::Entry',
    as   => 'emails',
  });
}

1;
