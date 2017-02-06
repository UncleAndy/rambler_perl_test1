#!/usr/bin/perl

use strict;

use HTTP::Async;
use HTML::LinkExtor;
use HTTP::Request;
use Image::Magick;

sub get_images_sizes() {
  my ($body) = @_;
  my $result = {};
  my $p = HTML::LinkExtor->new;
  $p->parse($body);
  my @links = $p->links;
  my @images_links;
  foreach my $link (@links) {
    my($tag, %attrs) = @{$link};
    if ($tag eq 'img' && defined($attrs{src}) && $attrs{src} ne '') {
      if ($attrs{src} =~ /^http/) {
        push(@images_links, $attrs{src});
      }
    }
  }

  my $async = HTTP::Async->new;
  $async->timeout(10);
  $async->max_request_time(20);

  my %async_ids;
  for ( my $i = 0; $i <= $#images_links; $i++ ) {
    my $img = @images_links[$i];
    my $async_id = $async->add(HTTP::Request->new( GET => $img ));
    $async_ids{$async_id} = $i;
  }

  while (my ($response, $async_id) = $async->wait_for_next_response) {
    if ($response->is_success) {
      my $body = $response->content;
      
      my $im = new Image::Magick;
      my ($width, $height, $size, $format) = $im->Ping(blob=>$body);
      
      $result->{@images_links[$async_ids{$async_id}]} = {
        width => $width,
        height => $height,
      };
    }
  }
  
  return $result;
}

1;
