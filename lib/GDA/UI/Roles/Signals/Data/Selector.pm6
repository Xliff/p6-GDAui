use v6.c;

use NativeCall;

use GDA::UI::Raw::Types;

use GLib::Object::Supplyish;

role GDA::UI::Roles::Signals::Data::Selector {
  has %!signals-guds;

  # GdauiDataSelector --> void
  method connect-selection-changed (
    $obj,
    $signal = 'selection-changed',
    &handler?
  ) {
    my $hid;
    %!signals-guds{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-selection-changed($obj, $signal,
        -> $ {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit(self);
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, 𝒮), $obj, $hid ];
    };
    %!signals-guds{$signal}[0].tap(&handler) with &handler;
    %!signals-guds{$signal}[0];
  }

}

# GdauiDataSelector *iface
sub g-connect-selection-changed (
  Pointer $app,
  Str     $name,
          &handler (Pointer ),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
