use v6.c;

use NativeCall;

use GDA::UI::Raw::Types;

role GDA::UI::Roles::Signals::RawGrid {
  has %!signals-gurg;

  # GdauiRawGrid, GtkMenu *menu --> void
  method connect-populate-popup (
    $obj,
    $signal = 'populate-popup',
    &handler?
  ) {
    my $hid;
    %!signals-gurg{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-populate-popup($obj, $signal,
        -> $, $gm {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $gm] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gurg{$signal}[0].tap(&handler) with &handler;
    %!signals-gurg{$signal}[0];
  }

}

# GdauiRawGrid *grid,  GtkMenu *menu
sub g-connect-populate-popup (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  GtkMenu),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
