use v6.c;

use NativeCall;

use GDA::UI::Raw::Types;

use GLib::Raw::ReturnedValue;

role GDA::UI::Roles::Signals::Tree::Store {
  has %!signals-guts;

  #  Str *path --> gboolean
  method connect-drag (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-guts{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-drag($obj, $signal,
        -> $, $s {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $s, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-guts{$signal}[0].tap(&handler) with &handler;
    %!signals-guts{$signal}[0];
  }


  #  Str *path,  GtkSelectionData *selection_data --> gboolean
  method connect-dnd (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-guts{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-dnd($obj, $signal,
        -> $, $s, $gsd {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $s, $gsd, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-guts{$signal}[0].tap(&handler) with &handler;
    %!signals-guts{$signal}[0];
  }

}

# GdauiTreeStore *store,  Str *path --> gboolean
sub g-connect-drag (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  Str --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdauiTreeStore *store,  Str *path,  GtkSelectionData *selection_data --> gboolean
sub g-connect-dnd (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  Str, GtkSelectionData --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
