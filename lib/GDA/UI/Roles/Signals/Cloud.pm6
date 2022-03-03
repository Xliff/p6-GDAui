use v6.c;

use NativeCall;

use GDA::UI::Raw::Types;


role GDA::UI::Roles::Signals::Cloud {
  has %!signals-guc;
  
  #  gint row --> void
  method connect-activate (
    $obj,
    $signal = 'activate',
    &handler?
  ) {
    my $hid;
    %!signals-guc{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-activate($obj, $signal,
        -> $, $g {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $g, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-guc{$signal}[0].tap(&handler) with &handler;
    %!signals-guc{$signal}[0];
  }

# GdauiCloud *cloud,  gint row
sub g-connect-activate (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  gint),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
