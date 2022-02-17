use v6.c

use Method::Also;
use NativeCall;

use GDA::UI::Raw::Types;

use GLib::Value;
use GTK::Box;
# use GDA::UI::DataProxy;
# use GDA::UI::Manager;

our subset GdauiDataProxyInfoAncestry is export of Mu
  where GdauiDataProxyInfo | GtkBoxAncestry;

class GDA::UI::DataProxyInfo is GTK::Box {
  has GdauiDataProxyInfo $!gudpi;

  submethod BUILD( :$gda-data-proxy-info ) {
    self.setGdauiDataProxyInfo($gda-data-proxy-info) if $gda-data-proxy-info;
  }

  method setGdauiDataProxyInfo (GdauiDataProxyInfoAncestry $_) {
    my $to-parent;

    $!gudpi = do {
      when GdauiDataProxyInfo {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkBox, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method GDA::Raw::Definitions::GdauiDataProxyInfo
    is also<GdauiDataProxyInfo>
  { $!gudpi }

  # Type: GdauiDataProxy
  method data-proxy ( :$raw = False ) is rw  is also<data_proxy> {
    my $gv = GLib::Value.new( GDA::UI::DataProxy.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
   	      self.prop_get('data-proxy', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::UI::DataProxy.getTypePair
        );
      },
      STORE => -> $, GdauiDataProxy() $val is copy {
        $gv.object = $val;
        self.prop_set('data-proxy', $gv);
      }
    );
  }

  # Type: GdauiDataProxyInfoFlag
  method flags is rw {
    my $gv = GLib::Value.new(
      GLib::Value.typeFromEnum(GdauiDataProxyInfoFlagEnum)
    );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('flags', $gv)
        );
        $gv.flags;
      },
      STORE => -> $, Int() $val is copy {
        $gv.integer = $val;
        self.prop_set('flags', $gv);
      }
    );
  }

 # Type: GdauiUiManager
  method ui-manager ( :$raw = False ) is rw is also<ui_manager> {
    my $gv = GLib::Value.new( GDA::UI::Manager.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
 	        self.prop_get('ui-manager', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::UI::Manager.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'ui-manager does not allow writing'
      }
    );
  }

  multi method new (
    GdauiDataProxyInfoAncestry  $gda-data-proxy-info,
                               :$ref = True
  ) {
    return Nil unless $gda-data-proxy-info;

    my $o = self.bless( :$gda-data-proxy-info );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdauiDataProxy() $proxy, Int() $flags) {
    my GdauiDataProxyInfoFlag $f = $flags;

    my $gdaui-data-proxy-info = gdaui_data_proxy_info_new($proxy, $f);

    $gdaui-data-proxy-info ?? self.bless( :$gdaui-data-proxy-info ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_data_proxy_info_get_type, $n, $t );
  }

}

### /usr/src/libgda5-5.2.10/libgda-ui/gdaui-data-proxy-info.h

sub gdaui_data_proxy_info_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_data_proxy_info_new (
  GdauiDataProxy         $data_proxy,
  GdauiDataProxyInfoFlag $flags
)
  returns GtkWidget
  is native(gdaui)
  is export
{ * }
