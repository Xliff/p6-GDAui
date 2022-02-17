use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GDA::UI::Raw::Definitions;
use GDA::UI::Raw::Structs;

unit package GDA::UI::RTEditor;

### /usr/src/libgda5-5.2.10/libgda-ui/gdaui-rt-editor.h

sub gdaui_rt_editor_get_contents (GdauiRtEditor $editor)
  returns Str
  is native(gdaui)
  is export
{ * }

sub gdaui_rt_editor_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_rt_editor_new ()
  returns GdauiRtEditor
  is native(gdaui)
  is export
{ * }

sub gdaui_rt_editor_set_contents (
  GdauiRtEditor $editor,
  Str           $markup,
  gint          $length
)
  is native(gdaui)
  is export
{ * }

sub gdaui_rt_editor_set_editable (GdauiRtEditor $editor, gboolean $editable)
  is native(gdaui)
  is export
{ * }
