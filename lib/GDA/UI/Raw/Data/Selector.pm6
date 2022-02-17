use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;
use GDA::UI::Raw::Definitions;
use GDA::UI::Raw::Enums;
use GDA::UI::Raw::Structs;

unit package GDA::UI::Raw::Data::Selector;

### /usr/src/libgda5-5.2.10/libgda-ui/gdaui-data-selector.h

sub gdaui_data_selector_get_data_set (GdauiDataSelector $iface)
  returns GdaDataModelIter
  is native(gdaui)
  is export
{ * }

sub gdaui_data_selector_get_model (GdauiDataSelector $iface)
  returns GdaDataModel
  is native(gdaui)
  is export
{ * }

sub gdaui_data_selector_get_selected_rows (GdauiDataSelector $iface)
  returns GArray
  is native(gdaui)
  is export
{ * }

sub gdaui_data_selector_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_data_selector_select_row (GdauiDataSelector $iface, gint $row)
  returns uint32
  is native(gdaui)
  is export
{ * }

sub gdaui_data_selector_set_column_visible (
  GdauiDataSelector $iface,
  gint              $column,
  gboolean          $visible
)
  is native(gdaui)
  is export
{ * }

sub gdaui_data_selector_set_model (
  GdauiDataSelector $iface,
  GdaDataModel      $model
)
  is native(gdaui)
  is export
{ * }

sub gdaui_data_selector_unselect_row (GdauiDataSelector $iface, gint $row)
  is native(gdaui)
  is export
{ * }
