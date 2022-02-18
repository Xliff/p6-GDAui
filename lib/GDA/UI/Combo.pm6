use v6.c;

use Method::Also;
use NativeCall;

use GDA::UI::Raw::Types;
use GDA::UI::Raw::Combo;

use GTK::ComboBox;

our subset GdauiComboAncestry is export of Mu
  where GdauiCombo | GtkComboBoxAncestry;

class GDA::UI::Combo is GTK::ComboBox {
  has GdauiCombo $!guc is implementor;

  submethod BUILD( :$gda-combo ) {
    self.setGdauiCombo($gda-combo) if $gda-combo;
  }

  method setGdauiCombo (GdauiComboAncestry $_) {
    my $to-parent;

    $!guc = do {
      when GdauiCombo {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkComboBox, $_);
      }
    }
    self.setGtkComboBox($to-parent);
  }

  method GDA::Raw::Definitions::GdauiCombo
    is also<GdauiCombo>
  { $!guc }

  multi method new (GdauiComboAncestry $gda-combo, :$ref = True) {
    return Nil unless $gda-combo;

    my $o = self.bless(:$gda-combo);
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $gdaui-combo = gdaui_combo_new();

    $gdaui-combo ?? self.bless( :$gdaui-combo ) !! Nil;
  }

  proto method new_with_model (|)
    is also<new-with-model>
  { * }

  multi method new_with_model (
    GdaDataModel() $model,
                   @cols_index
  ) {
    samewith( $model, @cols_index.elems, ArrayToCArray( gint, @cols_index ) )
  }
  multi method new_with_model (
    GdaDataModel() $model,
    Int()          $n_cols,
    CArray[gint]   $cols_index
  ) {
    my gint $n  = $n_cols;

    my $gdaui-combo = gdaui_combo_new_with_model($model, $n, $cols_index);

    $gdaui-combo ?? self.bless( :$gdaui-combo ) !! Nil;
  }

  method add_null (Int() $add_null) is also<add-null> {
    my gboolean $a = $add_null.so.Int;
    gdaui_combo_add_null($!guc, $add_null);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_combo_get_type, $n, $t );
  }

  method is_null_selected is also<is-null-selected> {
    so gdaui_combo_is_null_selected($!guc);
  }

  proto method set_data (|)
    is also<set-data>
  { * }

  multi method set_data (
    GdaDataModel() $model,
                   @cols_index
  ) {
    samewith( $model, @cols_index.elems, ArrayToCArray(gint, @cols_index) )
  }
  multi method set_data (
    GdaDataModel() $model,
    Int()          $n_cols,
    CArray[gint]   $cols_index
  ) {
    my gint $n  = $n_cols;

    gdaui_combo_set_data($!guc, $model, $n_cols, $cols_index);
  }

  proto method set_model (|)
    is also<set-model>
  { * }

  multi method set_model (
    GdaDataModel() $model,
                   @cols
  ) {
    samewith( $model, @cols.elems, ArrayToCArray(gint, @cols) );
  }
  multi method set_model (
    GdaDataModel() $model,
    Int()          $n_cols,
    CArray[gint]   $cols_index
  ) {
    gdaui_combo_set_model($!guc, $model, $n_cols, $cols_index);
  }

}
