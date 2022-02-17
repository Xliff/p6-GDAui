use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GDA::Raw::Structs;
use GDA::UI::Raw::Definitions;
use GDA::UI::Raw::Enums;
use GDA::UI::Raw::Structs;

### /usr/src/libgda5-5.2.10/libgda-ui/gdaui-data-proxy.h

unit package GDA::UI::Raw::Data::Proxy;

sub gdaui_data_proxy_column_set_editable (
  GdauiDataProxy $iface,
  gint           $column,
  gboolean       $editable
)
  is native(gdaui)
  is export
{ * }

sub gdaui_data_proxy_column_show_actions (
  GdauiDataProxy $iface,
  gint           $column,
  gboolean       $show_actions
)
  is native(gdaui)
  is export
{ * }

sub gdaui_data_proxy_get_actions_group (GdauiDataProxy $iface)
  returns GActionGroup
  is native(gdaui)
  is export
{ * }

sub gdaui_data_proxy_get_proxy (GdauiDataProxy $iface)
  returns GdaDataProxy
  is native(gdaui)
  is export
{ * }

sub gdaui_data_proxy_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_data_proxy_get_write_mode (GdauiDataProxy $iface)
  returns GdauiDataProxyWriteMode
  is native(gdaui)
  is export
{ * }

sub gdaui_data_proxy_perform_action (
  GdauiDataProxy $iface,
  GdauiAction    $action
)
  is native(gdaui)
  is export
{ * }

sub gdaui_data_proxy_set_write_mode (
  GdauiDataProxy          $iface,
  GdauiDataProxyWriteMode $mode
)
  returns uint32
  is native(gdaui)
  is export
{ * }
