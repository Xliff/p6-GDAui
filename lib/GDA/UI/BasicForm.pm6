use v6.c;

use Method::Also;

use LibXML::Raw;

use GDA::UI::Raw::Types;
use GDA::UI::Raw::BasicForm;

use GTK::Box;

use GDA::UI::Roles::Signals::BasicForm;

our subset GdauiBasicFormAncestry is export of Mu
  where GdauiBasicForm | GtkBoxAncestry;

class GDA::UI::BasicForm is GTK::Box {
  also does GDA::UI::Roles::Signals::BasicForm;

  has GdauiBasicForm $!gubf is implementor;

  submethod BUILD( :$gda-ui-basic-form ) {
    self.setGdauiBasicForm($gda-ui-basic-form) if $gda-ui-basic-form;
  }

  method setGdauiBasicForm (GdauiBasicFormAncestry $_) {
    my $to-parent;

    $!gubf = do {
      when GdauiBasicForm {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdauiBasicForm, $_);
      }
    }
    self.setBox($to-parent);
  }

  method GDA::Raw::Definitions::GdauiBasicForm
    is also<GdauiBasicForm>
  { $!gubf }

  proto method new (|)
  { * }

  multi method new (GdauiBasicFormAncestry $gda-ui-basic-form, :$ref = True) {
    return Nil unless $gda-ui-basic-form;

    my $o = self.bless(:$gda-ui-basic-form);
    $o.ref if $ref;
    $o;
  }
  multi method new (GdaSet() $data-set) {
    my $gda-ui-basic-form = gdaui_basic_form_new($data-set);

    $gda-ui-basic-form ?? self.bless( :$gda-ui-basic-form ) !! Nil;
  }

  method new_in_dialog (
    GdaSet()    $data_set,
    GtkWindow() $parent,
    Str()       $title,
    Str()       $header
  )
    is also<new-in-dialog>
  {
    my $gda-ui-basic-form = gdaui_basic_form_new_in_dialog(
      $data_set,
      $parent,
      $title,
      $header
    );

    $gda-ui-basic-form ?? self.bless( :$gda-ui-basic-form ) !! Nil;
  }


  # Type: gboolean
  method can-expand-v is rw  is also<can_expand_v> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('can-expand-v', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'can-expand-v does not allow writing'
      }
    );
  }

  # Type: gboolean
  method entries-auto-default is rw  is also<entries_auto_default> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('entries-auto-default', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('entries-auto-default', $gv);
      }
    );
  }

  # Type: gboolean
  method headers-sensitive is rw  is also<headers_sensitive> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('headers-sensitive', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('headers-sensitive', $gv);
      }
    );
  }

  # Type: GdaSet
  method paramlist ( :$raw = False ) is rw  {
    my $gv = GLib::Value.new( GDA::Set.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('paramlist', $gv)
        );
        propReturnObject(
          $gv.TYPE,
          $raw,
          |GDA::Set.getTypePair
        );
      },
      STORE => -> $, GdaSet() $val is copy {
        $gv.object = $val;
        self.prop_set('paramlist', $gv);
      }
    );
  }

  # Type: gboolean
  method show-actions is rw  is also<show_actions> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('show-actions', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-actions', $gv);
      }
    );
  }

  # Type: gpointer (anyNode)
  method xml-layout is rw  is also<xml_layout> {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        warn 'xml-layout does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, anyNode() $val is copy {
        $gv.pointer = $val;
        self.prop_set('xml-layout', $gv);
      }
    );
  }

  # Is originally:
  # GdauiBasicForm, gpointer
  method activated {
    self.connect-form($!gubf, 'activated');
  }

  # Is originally:
  # GdauiBasicForm, gpointer
  method layout-changed is also<layout_changed> {
    self.connect-form($!gubf, 'layout-changed');
  }

  # Is originally:
  # GdauiBasicForm, GtkMenu, gpointer
  method populate-popup is also<populate_popup> {
    self.connect-populate-popup($!gubf);
  }

  # Is originally:
  # GdauiBasicForm, gpointer
  method holder-changed is also<holder_changed> {
    self.connect-holder-changed($!gubf)
  }

  method add_to_size_group (
    GtkSizeGroup       $size_group,
    GdauiBasicFormPart $part
  )
    is also<add-to-size-group>
  {
    gdaui_basic_form_add_to_size_group($!gubf, $size_group, $part);
  }

  method entry_grab_focus (GdaHolder() $holder) is also<entry-grab-focus> {
    gdaui_basic_form_entry_grab_focus($!gubf, $holder);
  }

  method entry_set_editable (GdaHolder() $holder, Int() $editable)
    is also<entry-set-editable>
  {
    my gboolean $e = $editable.so.Int;

    gdaui_basic_form_entry_set_editable($!gubf, $holder, $e);
  }

  method entry_set_visible (GdaHolder() $holder, Int() $show)
    is also<entry-set-visible>
  {
    my gboolean $s = $show.so.Int;

    gdaui_basic_form_entry_set_visible($!gubf, $holder, $s);
  }

  method get_data_set ( :$raw = False ) is also<get-data-set> {
    propReturnObject(
      gdaui_basic_form_get_data_set($!gubf),
      $raw,
      |GDA::Set.getTypePair
    );
  }

  method get_entry_widget (GdaHolder() $holder, :$raw = False)
    is also<get-entry-widget>
  {
    propReturnObject(
      gdaui_basic_form_get_entry_widget($!gubf, $holder),
      $raw,
      |GTK::Widget.getTypePair
    );
  }

  method get_label_widget (GdaHolder() $holder, :$raw = False)
    is also<get-label-widget>
  {
    propReturnObject(
      gdaui_basic_form_get_label_widget($!gubf, $holder),
      $raw,
      |GTK::Widget.getTypePair
    );
  }

  method get_place_holder (Str() $placeholder_id, :$raw = False)
    is also<get-place-holder>
  {
    propReturnObject(
      gdaui_basic_form_get_place_holder($!gubf, $placeholder_id),
      $raw,
      |GTK::Widget.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_basic_form_get_type, $n, $t );
  }

  method has_changed is also<has-changed> {
    so gdaui_basic_form_has_changed($!gubf);
  }

  method is_valid is also<is-valid> {
    so gdaui_basic_form_is_valid($!gubf);
  }

  method remove_from_size_group (
    GtkSizeGroup()       $size_group,
    GdauiBasicFormPart() $part
  )
    is also<remove-from-size-group>
  {
    gdaui_basic_form_remove_from_size_group($!gubf, $size_group, $part);
  }

  method reset {
    gdaui_basic_form_reset($!gubf);
  }

  method set_as_reference is also<set-as-reference> {
    gdaui_basic_form_set_as_reference($!gubf);
  }

  method set_entries_to_default is also<set-entries-to-default> {
    gdaui_basic_form_set_entries_to_default($!gubf);
  }

  method set_layout_from_file (Str() $file_name, Str() $form_name)
    is also<set-layout-from-file>
  {
    gdaui_basic_form_set_layout_from_file($!gubf, $file_name, $form_name);
  }

  method set_unknown_color (
    Num() $red,
    Num() $green,
    Num() $blue,
    Num() $alpha
  )
    is also<set-unknown-color>
  {
    my gdouble ($r, $g, $b, $a) = ($red, $green, $blue, $alpha);

    gdaui_basic_form_set_unknown_color($!gubf, $r, $g, $b, $a);
  }

}
