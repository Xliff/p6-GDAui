use v6.c;

use Method::Also;

use NativeCall;

use GDA::UI::Raw::Types;

use GDA::UI::BasicForm;

use GDA::Roles::Data::Model;

our subset GdauiRawFormAncestry is export of Mu
  where GdauiRawForm | GdauiBasicFormAncestry;

class GDA::UI::RawForm is GDA::UI::BasicForm {
  has GdauiRawForm $!gurf is implementor;

  submethod BUILD ( :$gda-ui-raw-form ) {
    self.setGdauiRawForm($gda-ui-raw-form) if $gda-ui-raw-form;
  }

  method setGdauiRawForm (GdauiRawFormAncestry $_) {
    my $to-parent;

    $!gurf = do {
      when GdauiRawForm {
        $to-parent = cast(GdauiBasicForm, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdauiRawForm, $_);
      }
    }
    self.setGdauiBasicForm($to-parent);
  }

  method GDA::UI::Raw::Structs::GdauiRawForm
    is also<GdauiRawForm>
  { $!gurf }

  multi method new (
    GdauiRawFormAncestry  $gda-ui-raw-form,
                         :$ref              = True
  ) {
    return Nil unless $gda-ui-raw-form;

    my $o = self.bless( :$gda-ui-raw-form );
    $o.ref if $ref;
    $o
  }
  multi method new (GdaDataModel() $model) {
    my $gdaui-raw-form = gdaui_raw_form_new($model);

    $gdaui-raw-form ?? self.bless( :$gdaui-raw-form ) !! Nil;
  }

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
        );
      },
      STORE => -> $, GdaDataModel() $val is copy {
        $gv.object = $val;
        self.prop_set('model', $gv);
      }
    );
  }


  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_raw_form_get_type, $n, $t );
  }

}

### /usr/src/libgda5-5.2.10/libgda-ui/gdaui-raw-form.h

sub gdaui_raw_form_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_raw_form_new (GdaDataModel $model)
  returns GdauiRawForm
  is native(gdaui)
  is export
{ * }
