use v6.c;

use Method::Also;

use GDA::UI::Raw::Types;
use GDA::UI::Raw::EntryShell;

use GDA::Roles::Data::Handler;
use GTK::Box;

our subset GdauiEntryShellAncestry is export of Mu
  where GdauiEntryShell | GtkBoxAncestry;

class GDA::UI::EntryShell is GTK::Box {
  has GdauiEntryShell $!gues;

  submethod BUILD( :$gda-ui-entry-shell ) {
    self.setGduiEntryShell($gda-ui-entry-shell) if $gda-ui-entry-shell;
  }

  submethod TWEAK {
    # cw: Now this is novel!
    #
    #     Aside from the identity constructor, we rely on the PARENT for
    #     object creation. Therefore we have to pull what we need AFTER
    #     the parent has done its work. This is one way to accomplish
    #     that bit of init.
    unless $!gues {
      $!gues = cast(GdauiEntryShell, self.GtkBox);
    }
  }

  method setGdauiEntryShell (GdauiEntryShellAncestry $_) {
    my $to-parent;

    $!gues = do {
      when GdauiEntryShell {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdauiEntryShell, $_);
      }
    }
    self.setBox($to-parent);
  }

  method GDA::Raw::Structs::GdauiEntryShell
    is also<GdauiEntryShell>
  { $!gues }


  multi method new (GdauiEntryShellAncestry $gda-ui-entry-shell, :$ref = True) {
    return Nil unless $gda-ui-entry-shell;

    my $o = self.bless(:$gda-ui-entry-shell);
    $o.ref if $ref;
    $o;
  }

  # Type: boolean
  method actions is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('actions', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('actions', $gv);
      }
    );
  }

  # Type: GdauiDataHandler
  method handler ( :$raw = False ) is rw  {
    my $gv = GLib::Value.new( GDA::Data::Handler.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('handler', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Data::Handler.getTypePair
        )
      },
      STORE => -> $, GdaDataHandler() $val is copy {
        $gv.object = $val;
        self.prop_set('handler', $gv);
      }
    );
  }

  # Type: boolean
  method is-cell-renderer is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('is-cell-renderer', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('is-cell-renderer', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_entry_shell_get_type, $n, $t )
  }

  method pack_entry (GtkWidget() $main_widget) is also<pack-entry> {
    gdaui_entry_shell_pack_entry($!gues, $main_widget);
  }

  method refresh {
    gdaui_entry_shell_refresh($!gues);
  }

  method set_ucolor (Num() $red, Num() $green, Num() $blue, Num() $alpha)
    is also<set-ucolor>
  {
    my gdouble ($r, $g, $b, $a) = ($red, $green, $blue, $alpha);

    gdaui_entry_shell_set_ucolor($!gues, $r, $g, $b, $a);
  }

  method set_unknown (Int() $unknown) is also<set-unknown> {
    my gboolean $u = $unknown.so.Int;

    gdaui_entry_shell_set_unknown($!gues, $u);
  }

}
