use v6.c;

use GDA::UI::Raw::Types;
use GDA::UI::Raw::Data::Proxy;

use GDA::Data::Proxy;

use GIO::Roles::ActionGroup;
use GDA::UI::Roles::Signals::Data::Proxy;

role GDA::UI::Roles::Data::Proxy {
  use GDA::UI::Roles::Signals::Data::Proxy;

  has GdauiDataProxy $!gudp is implementor;

  method roleInit-GdauiDataProxy {
    return if $!gudp;

    my \i = findProperImplementor(self.^attributes);
    $!gdup = cast(GdauiDataProxy, i.get_value(self);
  }

  # Is originally:
  # GdauiDataProxy *iface,  GdaDataProxy *proxy --> void
  method proxy-changed {
    self.connect-proxy-changed($!gudp);
  }

  method column_set_editable (Int() $column, Int() $editable) {
    my gint     $c = $column;
    my gboolean $e = $editable.so.Int;

    gdaui_data_proxy_column_set_editable($!gudp, $c, $e);
  }

  method column_show_actions (Int() $column, Int() $show_actions) {
    my gint     $c = $column;
    my gboolean $s = $show_actions.so.Int;

    gdaui_data_proxy_column_show_actions($!gudp, $c, $s);
  }

  method get_actions_group ( :$raw = False ) {
    propReturnObject(
      gdaui_data_proxy_get_actions_group($!gudp),
      $raw,
      |GIO::ActionGroup.getTypePair
    );
  }

  method get_proxy ( :$raw = False ) {
    propReturnObject(
      gdaui_data_proxy_get_proxy($!gudp),
      $raw,
      |GDA::Data::Proxy.getTypePair
    );
  }

  method gdauidataproxy_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_data_proxy_get_type, $n, $t );
  }

  method get_write_mode {
    GdauiDataProxyWriteModeEnum( gdaui_data_proxy_get_write_mode($!gudp) )
  }

  method perform_action (GdauiAction() $action) {
    gdaui_data_proxy_perform_action($!gudp, $action);
  }

  method set_write_mode (Int() $mode) {
    my GdauiDataProxyWriteMode $m = $mode;

    gdaui_data_proxy_set_write_mode($!gudp, $mode);\
  }

}

use GLib::Roles::Object;

our subset GdauiDataProxyAncestry is export of Mu
  where GdauiDataProxy | GObject;

class GDA::UI::Data::Proxy {
  also does GLib::Roles::Object;
  also does GDA::UI::Roles::Data::Proxy;

  submethod BUILD ( :$gda-ui-dataproxy ) {
    self.setGdauiDataProxy($gda-ui-dataproxy) if $gda-ui-dataproxy;
  }

  method setGdauiDataProxy (GdauiDataProxyAncestry $_) {
    my $to-parent;

    $!gudp = do {
      when GdauiDataProxy {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdauiDataProxy, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GdauiDataProxy;
  }

  method GDA::UI::Raw::Definitions::GdauiDataProxy
    is also<GdauiDataProxy>
  { $!gudp }

  method new (GdauiDataProxyAncestry $gda-ui-dataproxy, :$ref = True) {
    return Nil unless $gda-ui-dataproxy;

    my $o = self.bless( :$gda-ui-dataproxy );
    $o.ref if $ref;
    $o;
  }

  method get_type {
    self.gdauidataproxy_get_type
  }
}
