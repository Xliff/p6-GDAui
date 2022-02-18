use v6.c;

use Method::Also;

use GDA::UI::Raw::Types;
use GDA::UI::Raw::Data::Selector;

use GLib::Array;

use GDA::Roles::Data::Model;
use GDA::UI::Roles::Signals::Data::Selector;

role GDA::UI::Roles::Data::Selector {
  also does GDA::UI::Roles::Signals::Data::Selector;

  has GdauiDataSelector $!guds is implementor;

  method roleInit-GdauiDataSelector is also<roleInit_GdauiDataSelector> {
    my \i = findProperImplementor( self.^attributes );

    $!guds = cast( GdauiDataSelector, i.get_value(self) );
  }

  method GDA::Raw::Definition::GdauiDataSelector
    is also<GdauiDataSelector>
  { $!guds }

  # Is originally:
  # GdauiDataSelector *iface --> void
  method selection-changed {
    self.connect-selection-changed($!guds);
  }

  method get_data_set is also<get-data-set> {
    gdaui_data_selector_get_data_set($!guds),
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      gdaui_data_selector_get_model($!guds),
      $raw,
      |GDA::Data::Model.getTypePair
    );
  }

  method get_selected_rows (:$raw = False, :$array = True)
    is also<get-selected-rows>
  {
    my $a = propReturnObject(
      gdaui_data_selector_get_selected_rows($!guds),
      $raw,
      |GLib::Array.getTypePair
    );

    return $a unless $array;

    $a.Array;
  }

  method gdauidataselector_get_type is also<gdauidataselector-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_data_selector_get_type, $n, $t );
  }

  method select_row (Int() $row) is also<select-row> {
    my gint $r = $row;

    gdaui_data_selector_select_row($!guds, $r);
  }

  method set_column_visible (Int() $column, Int() $visible)
    is also<set-column-visible>
  {
    my gint    $c = $column;
    my gboolean $v = $visible.so.Int;

    gdaui_data_selector_set_column_visible($!guds, $c, $v);
  }

  method set_model (GdauiDataSelector() $model) is also<set-model> {
    gdaui_data_selector_set_model($!guds, $model);
  }

  method unselect_row (Int() $row) is also<unselect-row> {
    my gint $r = $row;

    gdaui_data_selector_unselect_row($!guds, $r);
  }
}

our subset GdauiDataSelectorAncestry is export of Mu
  where GdauiDataSelector | GObject;

class GDA::UI::Data::Selector {
  also does GLib::Roles::Object;
  also does GDA::UI::Roles::Data::Selector;

  submethod BUILD ( :$gda-ui-data-selector ) {
    self.setGdauiDataSelector($gda-ui-data-selector) if $gda-ui-data-selector
  }

  method setGdauiDataSelector (GdauiDataSelectorAncestry $_) {
    my $to-parent;

    $!guds = do {
      when GdauiDataSelector {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdauiDataSelector, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (
    GdauiDataSelectorAncestry  $gda-ui-data-selector,
                              :$ref                   = True
  ) {
    return Nil unless $gda-ui-data-selector;

    my $o = self.bless( :$gda-ui-data-selector );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    self.gdauidataselector_get_type
  }
}
