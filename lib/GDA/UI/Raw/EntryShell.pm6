use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions;
use GDA::UI::Raw::Definitions;
use GDA::UI::Raw::Structs;

unit package GDA::UI::Raw::EntryShell;

### /usr/src/libgda5-5.2.10/libgda-ui/data-entries/gdaui-entry-shell.h

sub gdaui_entry_shell_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_entry_shell_pack_entry (
  GdauiEntryShell $shell,
  GtkWidget       $main_widget
)
  is native(gdaui)
  is export
{ * }

sub gdaui_entry_shell_refresh (GdauiEntryShell $shell)
  is native(gdaui)
  is export
{ * }

sub gdaui_entry_shell_set_ucolor (
  GdauiEntryShell $shell,
  gdouble         $red,
  gdouble         $green,
  gdouble         $blue,
  gdouble         $alpha
)
  is native(gdaui)
  is export
{ * }

sub gdaui_entry_shell_set_unknown (GdauiEntryShell $shell, gboolean $unknown)
  is native(gdaui)
  is export
{ * }
