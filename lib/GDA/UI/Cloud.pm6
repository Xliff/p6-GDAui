use v6.c;

use GDA::UI::Raw::Types;
use GDA::UI::Raw::Cloud;

use GTK::Box;

use GDA::UI::Roles::Signals::Cloud;

our subset GdauiCloudAncestry is export of Mu
  where GdauiCloud | GtkBoxAncestry;

class GDA::UI::Cloud is GTK::Box {
  also does GDA::UI::Roles::Signals::Cloud;

  has GdauiCloud $!guc is implementor;

  submethod BUILD( :$gda-ui-cloud ) {
    self.setGdauiCloud($gda-ui-cloud) if $gda-ui-cloud;
  }

  method setGdauiCloud (GdauiCloudAncestry $_) {
    my $to-parent;

    $!gubf = do {
      when GdauiCloud {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdauiCloud, $_);
      }
    }
    self.setBox($to-parent);
  }

  method GDA::Raw::Definitions::GdauiCloud
    is also<GdauiCloud>
  { $!gubf }

  proto method new (|)
  { * }

  multi method new (GdauiCloudAncestry $gda-ui-cloud, :$ref = True) {
    return Nil unless $gda-ui-cloud;

    my $o = self.bless(:$gda-ui-cloud);
    $o.ref if $ref;
    $o;
  }

  method new (Int() $label_column, Int() $weight_column) {
    my gint ($l, $w) = ($label_column, $weight_column);

    my $gda-ui-cloud = gdaui_cloud_new($!guc, $l, $w);

    $gda-ui-cloud = self.bless( :$gda-ui-cloud ) !! Nil;
  }

  # Type: int
  method label-column is rw  {
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
  method max-scale is rw  {
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
  method min-scale is rw  {
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
  method weight-column is rw  {
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
    self.connect-activate($!w);
  }

  method create_filter_widget ( :$raw = False ) {
    self.ReturnWidget(gdaui_cloud_create_filter_widget($!guc), $raw);
  }

  method filter (Str() $filter) {
    gdaui_cloud_filter($!guc, $filter);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_cloud_get_type, $m, $n )
  }

  method set_selection_mode (GtkSelectionMode $mode) {
    my GtkSelectionMode $m = $mode;

    gdaui_cloud_set_selection_mode($!guc, $m);
  }

  method set_weight_func (&func, gpointer $data) {
    gdaui_cloud_set_weight_func($!guc, &func, $data);
  }

}
