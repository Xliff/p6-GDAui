use v6.c;

use Method::Also;

use GDA::UI::Raw::Types;
use GDA::UI::Raw::Cloud;

use GTK::Box;

use GDA::UI::Roles::Data::Selector;
use GDA::UI::Roles::Signals::Cloud;

our subset GdauiCloudAncestry is export of Mu
  where GdauiCloud | GdauiDataSelector | GtkBoxAncestry;

class GDA::UI::Cloud is GTK::Box {
  also does GDA::UI::Roles::Data::Selector;
  also does GDA::UI::Roles::Signals::Cloud;

  has GdauiCloud $!guc is implementor;

  submethod BUILD( :$gda-ui-cloud ) {
    self.setGdauiCloud($gda-ui-cloud) if $gda-ui-cloud;
  }

  method setGdauiCloud (GdauiCloudAncestry $_) {
    my $to-parent;

    $!guc = do {
      when GdauiCloud {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      when GdauiDataSelector {
        $to-parent = cast(GtkBox, $_);
        $!guds     = $_;
        cast(GdauiCloud, $_);
      }

      default {
        $to-parent = $_;
        cast(GdauiCloud, $_);
      }
    }
    self.setBox($to-parent);
    self.roleInit-GdauiDataSelector;
  }

  method GDA::Raw::Definitions::GdauiCloud
    is also<GdauiCloud>
  { $!guc }

  proto method new (|)
  { * }

  multi method new (GdauiCloudAncestry $gda-ui-cloud, :$ref = True) {
    return Nil unless $gda-ui-cloud;

    my $o = self.bless(:$gda-ui-cloud);
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GdaDataModel() $model,
    Int()          $label_column,
    Int()          $weight_column
  ) {
    my gint ($l, $w) = ($label_column, $weight_column);

    my $gda-ui-cloud = gdaui_cloud_new($model, $l, $w);

    $gda-ui-cloud ?? self.bless( :$gda-ui-cloud ) !! Nil;
  }

  # Type: int
  method label-column is rw  is also<label_column> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        warn 'label-column does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('label-column', $gv);
      }
    );
  }

  # Type: double
  method max-scale is rw  is also<max_scale> {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        warn 'max-scale does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('max-scale', $gv);
      }
    );
  }

  # Type: double
  method min-scale is rw  is also<min_scale> {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        warn 'min-scale does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('min-scale', $gv);
      }
    );
  }

  # Type: GdaDataModel
  method model is rw  {
    my $gv = GLib::Value.new( GDA::Data::Model.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'model does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GdaDataModel() $val is copy {
        $gv.object = $val;
        self.prop_set('model', $gv);
      }
    );
  }

  # Type: int
  method weight-column is rw  is also<weight_column> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        warn 'weight-column does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('weight-column', $gv);
      }
    );
  }

  # Is originally:
  # GdauiCloud *cloud,  gint row --> void
  method activate {
    self.connect-activate($!guc);
  }

  method create_filter_widget ( :$raw = False ) is also<create-filter-widget> {
    self.ReturnWidget(
      gdaui_cloud_create_filter_widget($!guc),
      $raw
    );
  }

  method filter (Str() $filter) {
    gdaui_cloud_filter($!guc, $filter);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_cloud_get_type, $n, $t )
  }

  method set_selection_mode (GtkSelectionMode $mode)
    is also<set-selection-mode>
  {
    my GtkSelectionMode $m = $mode;

    gdaui_cloud_set_selection_mode($!guc, $m);
  }

  method set_weight_func (&func, gpointer $data) is also<set-weight-func> {
    gdaui_cloud_set_weight_func($!guc, &func, $data);
  }

}
