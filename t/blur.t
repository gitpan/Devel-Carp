#!./perl -w

use Test;
plan test => 3;
require Devel::Carp;
ok 1;

package Blur;
use overload ('""' => \&stringify);
sub stringify { Carp::confess "I have a headache" }

package Opaque;
use overload ('""' => \&stringify);
sub stringify { die "Don't bother me" }

package main;

{
    my $u = [];

    bless $u, Opaque;
    Carp::carp $u;
    ok 1;

    $u = bless $u, Blur;
    Carp::carp "This is it: $u"; #shouldn't be fatal!
    ok 1;
    
}
