#!/usr/bin/perl

use strict;

use HTTP::Async;
use HTML::LinkExtor;
use HTTP::Request;
use Image::Magick;

require './get_images_sizes_lib.pl';

my $body = "";
while (<STDIN>) {
  $body .= $_;
}

my $sizes = get_images_sizes($body);

foreach my $img (keys %{$sizes}) {
  print $img, ": ", $sizes->{$img}->{width}, " x ", $sizes->{$img}->{height}, "\n";
}
