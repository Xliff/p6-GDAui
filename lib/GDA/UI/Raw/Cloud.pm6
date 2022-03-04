use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;
use GTK::Raw::Definitions;
use GTK::Raw::Enums;
use GDA::UI::Raw::Definitions;
use GDA::UI::Raw::Structs;

### /usr/src/libgda5-5.2.10/libgda-ui/gdaui-cloud.h

sub gdaui_cloud_create_filter_widget (GdauiCloud $cloud)
  returns GtkWidget
  is native(gdaui)
  is export
{ * }

sub gdaui_cloud_filter (GdauiCloud $cloud, Str $filter)
  is native(gdaui)
  is export
{ * }

sub gdaui_cloud_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_cloud_new (
  GdaDataModel $model,
  gint         $label_column,
  gint         $weight_column
)
  returns GdauiCloud
  is native(gdaui)
  is export
{ * }

sub gdaui_cloud_set_selection_mode (
  GdauiCloud       $cloud,
  GtkSelectionMode $mode
)
  is native(gdaui)
  is export
{ * }

sub gdaui_cloud_set_weight_func (
  GdauiCloud $cloud,
             &func (GdaDataModel, gint, gpointer --> gdouble),
  gpointer   $data
)
  is native(gdaui)
  is export
{ * }
