#!./perl -w

use Test;
plan test => 2;
require Devel::Carp;
ok 1;

package Blur;
use overload ('""' => \&stringify);

sub stringify {
    Carp::confess "I have a headache";
}

package main;

my $u = bless [], Blur;
eval { Carp::carp "This is it: $u" };
ok $@, '/DIED/';
