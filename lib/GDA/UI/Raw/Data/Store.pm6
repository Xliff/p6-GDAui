use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;
use GTK::Raw::Definitions;
use GTK::Raw::Structs;
use GDA::UI::Raw::Definitions;
use GDA::UI::Raw::Structs;

unit package GDA::UI::Raw::Data::Store;

### /usr/src/libgda5-5.2.10/libgda-ui/gdaui-data-store.h

sub gdaui_data_store_append (GdauiDataStore $store, GtkTreeIter $iter)
  returns uint32
  is native(gdaui)
  is export
{ * }

sub gdaui_data_store_delete (GdauiDataStore $store, GtkTreeIter $iter)
  is native(gdaui)
  is export
{ * }

sub gdaui_data_store_get_iter_from_values (
  GdauiDataStore $store,
  GtkTreeIter    $iter,
  GSList         $values,
  gint           $cols_index is rw
)
  returns uint32
  is native(gdaui)
  is export
{ * }

sub gdaui_data_store_get_proxy (GdauiDataStore $store)
  returns GdaDataProxy
  is native(gdaui)
  is export
{ * }

sub gdaui_data_store_get_row_from_iter (
  GdauiDataStore $store,
  GtkTreeIter    $iter
)
  returns gint
  is native(gdaui)
  is export
{ * }

sub gdaui_data_store_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_data_store_new (GdaDataModel $model)
  returns GtkTreeModel
  is native(gdaui)
  is export
{ * }

sub gdaui_data_store_set_value (
  GdauiDataStore $store,
  GtkTreeIter    $iter,
  gint           $col,
  GValue         $value
)
  returns uint32
  is native(gdaui)
  is export
{ * }

sub gdaui_data_store_undelete (GdauiDataStore $store, GtkTreeIter $iter)
  is native(gdaui)
  is export
{ * }
