use v6.c;

use Method::Also;

use GDA::UI::Raw::Types;
use GDA::UI::Raw::RTEditor;

use GTK::Box;

use GLib::Roles::Signals::Generic;

our subset GdauiRtEditorAncestry is export of Mu
  where GdauiRtEditor | GtkBoxAncestry;

class GDA::UI::RTEditor is GTK::Box {
  also does GLib::Roles::Signals::Generic;

  has GdauiRtEditor $!gurte;

  submethod BUILD ( :$gda-ui-rt-editor ) {
    self.setGdauiRtEditor($gda-ui-rt-editor) if $gda-ui-rt-editor;
  }

  method setGdauiRtEditor (GdauiRtEditorAncestry $_) {
    my $to-parent;

    $!gurte = do {
      when GdauiRtEditor {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdauiRtEditor, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method GDA::UI::Raw::Structs::GdauiRTEditor
    is also<GdauiRTEditor>
  { $!gurte }

  multi method new (
    GdauiRtEditorAncestry  $gda-ui-rt-editor,
                         :$ref              = True
  ) {
    return Nil unless $gda-ui-rt-editor;

    my $o = self.bless( :$gda-ui-rt-editor );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $gda-ui-rtediitor = gdaui_rt_editor_new();

    $gda-ui-rtediitor ?? self.bless( :$gda-ui-rtediitor ) !! Nil;
  }

  # Type: GdauiTextBuffer
  method buffer ( :$raw = False ) is rw  {
    my $gv = GLib::Value.new( GTK::TextBuffer.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('buffer', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::TextBuffer.getTypePair
        );
      },
      STORE => -> $, $val is copy {
        warn 'buffer does not allow writing'
      }
    );
  }

  # Type: boolean
  method in-scrolled-window is rw  is also<in_scrolled_window> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('in-scrolled-window', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('in-scrolled-window', $gv);
      }
    );
  }

  # Type: boolean
  method no-background is rw  is also<no_background> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('no-background', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('no-background', $gv);
      }
    );
  }

  # Type: boolean
  method show-markup is rw  is also<show_markup> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('show-markup', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-markup', $gv);
      }
    );
  }

  # Is originally:
  # GdauiRtEditor *editor --> void
  method changed {
    self.connect-changed($!gurte);
  }

  method get_contents is also<get-contents> {
    gdaui_rt_editor_get_contents($!gurte);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_rt_editor_get_type, $n, $t );
  }

  method set_contents (Str() $markup, Int() $length) is also<set-contents> {
    my gint $l = $length;

    gdaui_rt_editor_set_contents($!gurte, $markup, $l);
  }

  method set_editable (Int() $editable) is also<set-editable> {
    my gboolean $e = $editable.so.Int;

    gdaui_rt_editor_set_editable($!gurte, $e);
  }

}
