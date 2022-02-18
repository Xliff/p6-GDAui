use v6.c;

use NativeCall;
use Method::Also;

use GDA::UI::Raw::Types;

use GLib::Value;
use GTK::Box;

our subset GdauiFormAncestry is export of Mu
  where GdauiForm | GtkBoxAncestry;

class GDA::UI::Form is GTK::Box {
  has GdauiForm $!guf is implementor;

  submethod BUILD( :$gda-form ) {
    self.setGdauiForm($gda-form) if $gda-form;
  }

  method setGdauiForm (GdauiFormAncestry $_) {
    my $to-parent;

    $!guf = do {
      when GdauiForm {
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

  method GDA::Raw::Definitions::GdauiForm
    is also<GdauiForm>
  { $!guf }

  multi method new (GdauiFormAncestry $gda-form, :$ref = True) {
    return Nil unless $gda-form;

    my $o = self.bless( :$gda-form );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdaDataModel() $model) {
    my $gda-form = gdaui_form_new($model);

    $gda-form ?? self.bless( :$gda-form ) !! Nil;
  }

  # Type: GdauiDataProxyInfo
  method info ( :$raw = False ) is rw  {
    my $gv = GLib::Value.new( GDA::UI::DataProxyInfo.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
  	      self.prop_get('info', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::UI::DataProxyInfo.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'info does not allow writing'
      }
    );
  }

  # Type: GdauiDataProxyInfoFlag
  method info-flags is rw  is also<info_flags> {
    my $gv = GLib::Value.new(
      GLib::Value.typeFromEnum(GdauiDataProxyInfoFlagEnum)
    );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
  	      self.prop_get('info-flags', $gv)
        );
        $gv.flags;
      },
      STORE => -> $, Int() $val is copy {
        $gv.integer = $val;
        self.prop_set('info-flags', $gv);
      }
    );
  }

  # Type: GdauiDataModel
  method model is rw  {
    #my $gv = GLib::Value.new( GDA::UI::DataModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'model does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $,  $val is copy {
        warn 'model is a construct-only attribute'
      }
    );
  }

  # Type: GdauiRawForm
  method raw-form is rw  is also<raw_form> {
    my $gv = GLib::Value.new( GdauiRawForm );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
  	      self.prop_get('raw-form', $gv)
        );
        $gv.GdauiRawForm;
      },
      STORE => -> $,  $val is copy {
        warn 'raw-form does not allow writing'
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_form_get_type, $n, $t );
  }

}

### /usr/src/libgda5-5.2.10/libgda-ui/../libgda-ui/gdaui-form.h

sub gdaui_form_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_form_new (GdaDataModel $model)
  returns GtkWidget
  is native(gdaui)
  is export
{ * }
