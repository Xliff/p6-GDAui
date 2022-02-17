use v6.c;

use NativeCall;

use GDA::UI::Raw::Types;

role GDA::UI::Roles::Signals::BasicForm {
  has %!signals-gubf;

  # GtaTree, GtaTreeNode, gpointer
  method connect-holder-changed (
    $obj,
    $signal    = 'holder-changed',
    &handler?
  ) {
    my $hid;
    %!signals-gubf{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-holder-changed($obj, $signal,
        -> $, $h, $iua {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $h, $iua] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gubf{$signal}[0].tap(&handler) with &handler;
    %!signals-gubf{$signal}[0];
  }

  #
  method connect-populate-popup (
    $obj,
    $signal   = 'populate-popup',
    &handler?
  ) {
    my $hid;
    %!signals-gubf{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-populate-popup($obj, $signal,
        -> $ {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, self] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gubf{$signal}[0].tap(&handler) with &handler;
    %!signals-gubf{$signal}[0];
  }

  # GdaUiBasicForm
  method connect-form (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gubf{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-form($obj, $signal,
        -> $ {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( self );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gubf{$signal}[0].tap(&handler) with &handler;
    %!signals-gubf{$signal}[0];
  }

}

# GdauiBasicForm, GdaHolder, gboolean, gpointer
sub g-connect-holder-changed (
  Pointer $app,
  Str     $name,
          &handler (GdauiBasicForm, GdaHolder, gboolean, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdauiBasicForm, gpointer
sub g-connect-form (
  Pointer $app,
  Str     $name,
          &handler (GdauiBasicForm, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdauiBasicForm, GtkMenu, gpointer
sub g-connect-populate-popup (
  Pointer $app,
  Str     $name,
          &handler (GdauiBasicForm, GtkMenu, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
