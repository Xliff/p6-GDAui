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

unit package GDA::UI::Raw::BasicForm;

### /usr/src/libgda5-5.2.10/libgda-ui/gdaui-basic-form.h

sub gdaui_basic_form_add_to_size_group (
  GdauiBasicForm     $form,
  GtkSizeGroup       $size_group,
  GdauiBasicFormPart $part
)
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_entry_grab_focus (
  GdauiBasicForm $form,
  GdaHolder      $holder
)
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_entry_set_editable (
  GdauiBasicForm $form,
  GdaHolder      $holder,
  gboolean       $editable
)
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_entry_set_visible (
  GdauiBasicForm $form,
  GdaHolder      $holder,
  gboolean       $show
)
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_get_data_set (GdauiBasicForm $form)
  returns GdaSet
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_get_entry_widget (
  GdauiBasicForm $form,
  GdaHolder      $holder
)
  returns GtkWidget
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_get_label_widget (
  GdauiBasicForm $form,
  GdaHolder      $holder
)
  returns GtkWidget
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_get_place_holder (
  GdauiBasicForm $form,
  Str            $placeholder_id
)
  returns GtkWidget
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_has_changed (GdauiBasicForm $form)
  returns uint32
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_is_valid (GdauiBasicForm $form)
  returns uint32
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_new (GdaSet $data_set)
  returns GtkWidget
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_new_in_dialog (
  GdaSet    $data_set,
  GtkWindow $parent,
  Str       $title,
  Str       $header
)
  returns GtkWidget
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_remove_from_size_group (
  GdauiBasicForm     $form,
  GtkSizeGroup       $size_group,
  GdauiBasicFormPart $part
)
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_reset (GdauiBasicForm $form)
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_set_as_reference (GdauiBasicForm $form)
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_set_entries_to_default (GdauiBasicForm $form)
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_set_layout_from_file (
  GdauiBasicForm $form,
  Str            $file_name,
  Str            $form_name
)
  is native(gdaui)
  is export
{ * }

sub gdaui_basic_form_set_unknown_color (
  GdauiBasicForm $form,
  gdouble        $red,
  gdouble        $green,
  gdouble        $blue,
  gdouble        $alpha
)
  is native(gdaui)
  is export
{ * }
