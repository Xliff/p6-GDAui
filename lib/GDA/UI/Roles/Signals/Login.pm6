use v6.c;

use NativeCall;

use GDA::UI::Raw::Types;

role GDA::UI::Roles::Signals::Login {
  has %!signals-gul;

  #  GdauiLogin, gboolean is_valid --> void
  method connect-changed (
    $obj,
    $signal = 'changed',
    &handler?
  ) {
    my $hid;
    %!signals-gul{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-changed($obj, $signal,
        -> $, $b {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $b] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gul{$signal}[0].tap(&handler) with &handler;
    %!signals-gul{$signal}[0];
  }

}

# GdauiLogin *login,  gboolean is_valid
sub g-connect-changed (
  Pointer $app,
  Str     $name,
          &handler (GdauiLogin, gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
