use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;
use GTK::Raw::Definitions;
use GTK::Raw::Enums;
use GDA::UI::Raw::Definitions;
use GDA::UI::Raw::Enums;
use GDA::UI::Raw::Structs;

unit package GDA::UI::Raw::Combo;

### /usr/src/libgda5-5.2.10/libgda-ui/gdaui-combo.h

# Private - raw methods only!

sub _gdaui_combo_get_selected (GdauiCombo $combo)
  returns GSList
  is native(gdaui)
  is export
{ * }

sub _gdaui_combo_get_selected_ext (
  GdauiCombo $combo,
  gint       $n_cols,
  gint       $cols_index is rw
)
  returns GSList
  is native(gdaui)
  is export
{ * }

sub _gdaui_combo_set_selected (GdauiCombo $combo, GSList $values)
  returns uint32
  is native(gdaui)
  is export
{ * }

sub _gdaui_combo_set_selected_ext (
  GdauiCombo $combo,
  GSList     $values,
  gint       $cols_index is rw
)
  returns uint32
  is native(gdaui)
  is export
{ * }

sub gdaui_combo_add_null (GdauiCombo $combo, gboolean $add_null)
  is native(gdaui)
  is export
{ * }

sub gdaui_combo_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_combo_is_null_selected (GdauiCombo $combo)
  returns uint32
  is native(gdaui)
  is export
{ * }

sub gdaui_combo_new ()
  returns GdauiCombo
  is native(gdaui)
  is export
{ * }

sub gdaui_combo_new_with_model (
  GdaDataModel $model,
  gint         $n_cols,
  CArray[gint] $cols_index
)
  returns GdauiCombo
  is native(gdaui)
  is export
{ * }

sub gdaui_combo_set_data (
  GdauiCombo   $combo,
  GdaDataModel $model,
  gint         $n_cols,
  CArray[gint] $cols_index
)
  is native(gdaui)
  is export
{ * }

sub gdaui_combo_set_model (
  GdauiCombo   $combo,
  GdaDataModel $model,
  gint         $n_cols,
  CArray[gint] $cols_index
)
  is native(gdaui)
  is export
{ * }
