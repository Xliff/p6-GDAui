use v6.c;

use NativeCall;

use GDA::UI::Raw::Types;

role GDA::UI::Roles::Signals::Set {
  has %!signals-gus;

  #  GdauiSet --> void
  method connect-set (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gus{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-source-model-changed($obj, $signal,
        -> $ {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit(self);
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gus{$signal}[0].tap(&handler) with &handler;
    %!signals-gus{$signal}[0];
  }

  #  GdauiSet, GdauiSetSource --> void
  method connect-source-model-changed (
    $obj,
    $signal = 'source-model-changed',
    &handler?
  ) {
    my $hid;
    %!signals-gus{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-source-model-changed($obj, $signal,
        -> $, $gss {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $gss] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gus{$signal}[0].tap(&handler) with &handler;
    %!signals-gus{$signal}[0];
  }

}

# GdauiSet *set, GdauiSetSource *source
sub g-connect-set (
  Pointer $app,
  Str     $name,
          &handler (GdauiSet),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdauiSet *set, GdauiSetSource *source
sub g-connect-source-model-changed (
  Pointer $app,
  Str     $name,
          &handler (GdauiSet, GdauiSetSource),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
