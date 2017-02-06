#!/usr/bin/perl

use Test::More tests => 26;
use Data::Dumper;

require_ok('get_images_sizes_lib.pm');

my $test1_body = '';
my $test1;
if (open($test1, '<test.html')) {
  while (<$test1>) {
    $test1_body .= $_;
  }
}

my $result1 = get_images_sizes($test1_body);

my @keys = keys %{$result1};
ok($#keys == 11, "Images count is 12");
ok($result1->{'http://andyhost.ru/chicago_auto/000-IMG_0078.JPG.small.jpeg'}->{width} == 120, "Test1 img000 return width 120");
ok($result1->{'http://andyhost.ru/chicago_auto/000-IMG_0078.JPG.small.jpeg'}->{height} == 90, "Test1 img000 return height 90");
ok($result1->{'http://andyhost.ru/chicago_auto/001-IMG_0082.JPG.small.jpeg'}->{width} == 75, "Test1 img001 return width 75");
ok($result1->{'http://andyhost.ru/chicago_auto/001-IMG_0082.JPG.small.jpeg'}->{height} == 100, "Test1 img001 return height 100");
ok($result1->{'http://andyhost.ru/chicago_auto/002-IMG_0083.JPG.small.jpeg'}->{width} == 75, "Test1 img002 return width 75");
ok($result1->{'http://andyhost.ru/chicago_auto/002-IMG_0083.JPG.small.jpeg'}->{height} == 100, "Test1 img002 return height 100");
ok($result1->{'http://andyhost.ru/chicago_auto/003-IMG_0084.JPG.small.jpeg'}->{width} == 120, "Test1 img003 return width 120");
ok($result1->{'http://andyhost.ru/chicago_auto/003-IMG_0084.JPG.small.jpeg'}->{height} == 90, "Test1 img003 return height 90");
ok($result1->{'http://andyhost.ru/chicago_auto/004-IMG_0085.JPG.small.jpeg'}->{width} == 120, "Test1 img004 return width 120");
ok($result1->{'http://andyhost.ru/chicago_auto/004-IMG_0085.JPG.small.jpeg'}->{height} == 90, "Test1 img004 return height 90");
ok($result1->{'http://andyhost.ru/chicago_auto/005-IMG_0086.JPG.small.jpeg'}->{width} == 120, "Test1 img005 return width 120");
ok($result1->{'http://andyhost.ru/chicago_auto/005-IMG_0086.JPG.small.jpeg'}->{height} == 90, "Test1 img005 return height 90");
ok($result1->{'http://andyhost.ru/chicago_auto/006-IMG_0087.JPG.small.jpeg'}->{width} == 120, "Test1 img006 return width 120");
ok($result1->{'http://andyhost.ru/chicago_auto/006-IMG_0087.JPG.small.jpeg'}->{height} == 90, "Test1 img006 return height 90");
ok($result1->{'http://andyhost.ru/chicago_auto/007-IMG_0088.JPG.small.jpeg'}->{width} == 120, "Test1 img007 return width 120");
ok($result1->{'http://andyhost.ru/chicago_auto/007-IMG_0088.JPG.small.jpeg'}->{height} == 90, "Test1 img007 return height 90");
ok($result1->{'http://andyhost.ru/chicago_auto/008-IMG_0089.JPG.small.jpeg'}->{width} == 120, "Test1 img008 return width 120");
ok($result1->{'http://andyhost.ru/chicago_auto/008-IMG_0089.JPG.small.jpeg'}->{height} == 90, "Test1 img008 return height 90");
ok($result1->{'http://andyhost.ru/chicago_auto/009-IMG_0090.JPG.small.jpeg'}->{width} == 120, "Test1 img009 return width 120");
ok($result1->{'http://andyhost.ru/chicago_auto/009-IMG_0090.JPG.small.jpeg'}->{height} == 90, "Test1 img009 return height 90");
ok($result1->{'http://andyhost.ru/chicago_auto/010-IMG_0091.JPG.small.jpeg'}->{width} == 120, "Test1 img010 return width 120");
ok($result1->{'http://andyhost.ru/chicago_auto/010-IMG_0091.JPG.small.jpeg'}->{height} == 90, "Test1 img010 return height 90");
ok($result1->{'http://andyhost.ru/chicago_auto/011-IMG_0092.JPG.small.jpeg'}->{width} == 120, "Test1 img011 return width 120");
ok($result1->{'http://andyhost.ru/chicago_auto/011-IMG_0092.JPG.small.jpeg'}->{height} == 90, "Test1 img011 return height 90");
