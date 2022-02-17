use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
# use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;
use GTK::Raw::Definitions;
use GDA::UI::Raw::Definitions;
use GDA::UI::Raw::Structs;

### /usr/src/libgda5-5.2.10/libgda-ui/gdaui-raw-grid.h

# cw: Removed since not a part of the public API.
#     Included here coz ... autogenerated.
#
# sub _gdaui_raw_grid_get_selection (GdauiRawGrid $grid)
#   returns GList
#   is native(gdaui)
#   is export
# { * }

sub gdaui_raw_grid_add_formatting_function (
  GdauiRawGrid $grid,
               &func (
                GtkCellRenderer,
                GtkTreeViewColumn,
                gint,
                GdaDataModel,
                gint,
                gpointer
              ),
  gpointer    $data,
              &dnotify (gpointer)
)
  is native(gdaui)
  is export
{ * }

sub gdaui_raw_grid_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_raw_grid_new (GdaDataModel $model)
  returns GtkWidget
  is native(gdaui)
  is export
{ * }

sub gdaui_raw_grid_remove_formatting_function (
  GdauiRawGrid $grid,
  &func (
    GtkCellRenderer,
    GtkTreeViewColumn,
    gint,
    GdaDataModel,
    gint,
    gpointer
  )
)
  is native(gdaui)
  is export
{ * }

sub gdaui_raw_grid_set_layout_from_file (
  GdauiRawGrid $grid,
  Str          $file_name,
  Str          $grid_name
)
  is native(gdaui)
  is export
{ * }

sub gdaui_raw_grid_set_sample_size (GdauiRawGrid $grid, gint $sample_size)
  is native(gdaui)
  is export
{ * }

sub gdaui_raw_grid_set_sample_start (GdauiRawGrid $grid, gint $sample_start)
  is native(gdaui)
  is export
{ * }
