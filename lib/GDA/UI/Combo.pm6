use v6.c;

use Method::Also;
use NativeCall;

use GDA::UI::Raw::Types;
use GDA::UI::Raw::Combo;

use GTK::ComboBox;

use GDA::UI::Roles::Data::Selector;

our subset GdauiComboAncestry is export of Mu
  where GdauiCombo | GdauiDataSelector | GtkComboBoxAncestry;

class GDA::UI::Combo is GTK::ComboBox {
  also does GDA::UI::Roles::Data::Selector;

  has GdauiCombo $!guc is implementor;

  submethod BUILD( :$gda-ui-combo ) {
    self.setGdauiCombo($gda-ui-combo) if $gda-ui-combo;
  }

  method setGdauiCombo (GdauiComboAncestry $_) {
    my $to-parent;

    $!guc = do {
      when GdauiCombo {
        $to-parent = cast(GtkComboBox, $_);
        $_;
      }

      when GdauiDataSelector {
        $to-parent = cast(GtkComboBox, $_);
        $!guds     = $_;
        cast(GdauiCombo, $_);
      }

      default {
        $to-parent = $_;
        cast(GdauiCombo, $_);
      }
    }
    self.setGtkComboBox($to-parent);
    self.roleInit-GdauiDataSelector;
  }

  method GDA::Raw::Definitions::GdauiCombo
    is also<GdauiCombo>
  { $!guc }

  multi method new (GdauiComboAncestry $gda-ui-combo, :$ref = True) {
    return Nil unless $gda-ui-combo;

    my $o = self.bless(:$gda-ui-combo);
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $gda-ui-combo = gdaui_combo_new();

    $gda-ui-combo ?? self.bless( :$gda-ui-combo ) !! Nil;
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

    my $gda-ui-combo = gdaui_combo_new_with_model($model, $n, $cols_index);

    $gda-ui-combo ?? self.bless( :$gda-ui-combo ) !! Nil;
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
