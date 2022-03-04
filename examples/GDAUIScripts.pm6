use v6.c;

use GDA::UI::Raw::Types;

use GDA::Connection;
use GDA::Meta::Store;

unit package GDAUIScripts;

our $dirname is export = '.'.IO;

our $demo-cnc    is export;
our $demo-parser is export;

sub demo-find-file ($f, :$fatal = True) is export {
  my $io = $f.IO;
  return $io if $io.r;

  $dirname .= add('examples') unless $dirname.add($f).r;

  $io = $dirname.add($f);
  if $fatal {
    die "Cannot find demo file '$f'" unless $io.r;
  }
  $io
}

sub open-demo-connection ($f = 'demo_db.db') is export {
  demo-find-file($f);

  my $cncstring = "DB_DIR={ $dirname.absolute };DB_NAME=$f";
  $demo-cnc = GDA::Connection.open-from-string('SQlite', $cncstring);
  without $demo-cnc {
    $*ERR.say: "Error opening the connection for file `$f`: {
      $ERROR && $ERROR.message ?? $ERROR.message !!'No detail' }";
    exit 1;
  }

  my $update-meta-store = False;
  $demo-cnc.meta-store = do if demo-find-file('demo_meta.db', :!fatal) -> $f {
    $f.say;
    $update-meta-store = True;
    GDA::Meta::Store.new-with-file($f);
  } else {
    GDA::Meta::Store.new
  }
  $demo-cnc.update-meta-store if $update-meta-store;
  $demo-cnc.execution-slowdown = 1000000;

  $demo-parser = $demo-cnc.create-parser;
  $demo-parser //= GDA::SQL::Parser.new;

  $demo-cnc;
}
