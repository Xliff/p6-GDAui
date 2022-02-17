use v6.c;

use Method::Also;

use GDA::UI::Raw::Types;
use GDA::UI::Raw::RawGrid;

use GTK::TreeView;

our subset GdauiRawGridAncestry is export of Mu
  where GdauiRawGrid | TreeViewAncestry;

class GDA::UI::RawGrid is GTK::TreeView {
  also does GLib::Roles::Signals::Generic;

  has GdauiRawGrid $!gurg;

  submethod BUILD ( :$gda-ui-raw-grid ) {
    self.setGdauiRawGrid($gda-ui-raw-grid) if $gda-ui-raw-grid;
  }

  method setGdauiRawGrid (GdauiRawGridAncestry $_) {
    my $to-parent;

    $!gurg = do {
      when GdauiRawGrid {
        $to-parent = cast(GtkTreeView, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdauiRawGrid, $_);
      }
    }
    self.setGtkTreeView($to-parent);
  }

  method GDA::UI::Raw::Structs::GdauiRawGrid
    is also<GdauiRawGrid>
  { $!gurg }

  multi method new (
    GdauiRawGridAncestry  $gda-ui-raw-grid,
                         :$ref              = True
  ) {
    return Nil unless $gda-ui-raw-grid;

    my $o = self.bless( :$gda-ui-raw-grid );
    $o.ref if $ref;
    $o
  }
  multi method new (GdaDataModel() $model) {
    my $gdaui-raw-grid = gdaui_raw_grid_new($model);

    $gdaui-raw-grid ?? self.bless( :$gdaui-raw-grid ) !! Nil;
  }

  # Type: boolean
  method global-actions-visible is rw  is also<global_actions_visible> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('global-actions-visible', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('global-actions-visible', $gv);
      }
    );
  }

  # Type: boolean
  method info-cell-visible is rw  is also<info_cell_visible> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('info-cell-visible', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('info-cell-visible', $gv);
      }
    );
  }

  # Type: GdaDataModel
  method model ( :$raw = False ) is rw  {
    my $gv = GLib::Value.new( GDA::Data::Model.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('model', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Data::Model.getTypePair
        )
      },
      STORE => -> $, GdaDataModel() $val is copy {
        $gv.object = $val;
        self.prop_set('model', $gv);
      }
    );
  }

  # Type: pointer
  method xml-layout is rw  is also<xml_layout> {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        warn 'xml-layout does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $,  $val is copy {
        $gv.pointer = $val;
        self.prop_set('xml-layout', $gv);
      }
    );
  }

  # Is originally:
  # GdauiRawGrid *grid,  gint row --> void
  method double-clicked is also<double_clicked> {
    self.connect-int($!gurg, 'double-clicked');
  }

  # Is originally:
  # GdauiRawGrid *grid,  GtkMenu *menu --> void
  method populate-popup is also<populate_popup> {
    self.connect-populate-popup($!gurg);
  }

  method add_formatting_function (&func, gpointer $data, &dnotify) is also<add-formatting-function> {
    gdaui_raw_grid_add_formatting_function($!gurg, &func, $data, &dnotify);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_raw_grid_get_type, $n, $t )
  }

  method remove_formatting_function (&func) is also<remove-formatting-function> {
    gdaui_raw_grid_remove_formatting_function($!gurg, &func);
  }

  method set_layout_from_file (Str() $file_name, Str() $grid_name) is also<set-layout-from-file> {
    gdaui_raw_grid_set_layout_from_file($!gurg, $file_name, $grid_name);
  }

  method set_sample_size (Int() $sample_size;) is also<set-sample-size> {
    my gint $s = $sample_size;

    gdaui_raw_grid_set_sample_size($!gurg, $s);
  }

  method set_sample_start (Int() $sample_start) is also<set-sample-start> {
    my gint $s = $sample_start;

    gdaui_raw_grid_set_sample_start($!gurg, $sample_start);
  }

}
