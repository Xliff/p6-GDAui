use v6.c;

use NativeCall;

use GDA::UI::Raw::Types;

role GDA::UI::Roles::Signals::Data::Proxy {
  has %!signals-gudp;

  #  GdauiDataProxy, GdaDataProxy --> void
  method connect-proxy-changed (
    $obj,
    $signal = 'proxy-changed',
    &handler?
  ) {
    my $hid;
    %!signals-gudp{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-proxy-changed($obj, $signal,
        -> $, $gdp {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $gdp] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gudp{$signal}[0].tap(&handler) with &handler;
    %!signals-gudp{$signal}[0];
  }
}

# GdauiDataProxy *iface,  GdaDataProxy *proxy
sub g-connect-proxy-changed (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GdaDataProxy),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
