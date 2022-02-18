use v6.c;

use NativeCall;

unit package GDA::UI::Raw::Set;


### /usr/src/libgda5-5.2.10/libgda-ui/gdaui-set.h

sub _gdaui_set_get_group (GdauiSet $dbset, GdaHolder $holder)
  returns GdauiSetGroup
  is native(gdaui)
  is export
{ * }

sub _gdaui_set_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub _gdaui_set_new (GdaSet $set)
  returns GdauiSet
  is native(gdaui)
  is export
{ * }

sub gdaui_set_get_group (GdauiSet $dbset, GdaHolder $holder)
  returns GdauiSetGroup
  is native(gdaui)
  is export
{ * }

sub gdaui_set_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_set_group_copy (GdauiSetGroup $sg)
  returns GdauiSetGroup
  is native(gdaui)
  is export
{ * }

sub gdaui_set_group_free (GdauiSetGroup $sg)
  is native(gdaui)
  is export
{ * }

sub gdaui_set_group_get_group (GdauiSetGroup $sg)
  returns GdaSetGroup
  is native(gdaui)
  is export
{ * }

sub gdaui_set_group_get_source (GdauiSetGroup $sg)
  returns GdauiSetSource
  is native(gdaui)
  is export
{ * }

sub gdaui_set_group_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_set_group_new (GdaSetGroup $group)
  returns GdauiSetGroup
  is native(gdaui)
  is export
{ * }

sub gdaui_set_group_set_group (GdauiSetGroup $sg, GdaSetGroup $group)
  is native(gdaui)
  is export
{ * }

sub gdaui_set_group_set_source (GdauiSetGroup $sg, GdauiSetSource $source)
  is native(gdaui)
  is export
{ * }

sub gdaui_set_new (GdaSet $set)
  returns GdauiSet
  is native(gdaui)
  is export
{ * }

sub gdaui_set_source_copy (GdauiSetSource $s)
  returns GdauiSetSource
  is native(gdaui)
  is export
{ * }

sub gdaui_set_source_free (GdauiSetSource $s)
  is native(gdaui)
  is export
{ * }

sub gdaui_set_source_get_ref_columns (GdauiSetSource $s)
  returns gint
  is native(gdaui)
  is export
{ * }

sub gdaui_set_source_get_ref_n_cols (GdauiSetSource $s)
  returns gint
  is native(gdaui)
  is export
{ * }

sub gdaui_set_source_get_shown_columns (GdauiSetSource $s)
  returns gint
  is native(gdaui)
  is export
{ * }

sub gdaui_set_source_get_shown_n_cols (GdauiSetSource $s)
  returns gint
  is native(gdaui)
  is export
{ * }

sub gdaui_set_source_get_source (GdauiSetSource $s)
  returns GdaSetSource
  is native(gdaui)
  is export
{ * }

sub gdaui_set_source_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_set_source_new (GdaSetSource $source)
  returns GdauiSetSource
  is native(gdaui)
  is export
{ * }

sub gdaui_set_source_set_ref_columns (
  GdauiSetSource $s,
  CArray[gint]   $columns, 
  gint           $n_columns
)
  is native(gdaui)
  is export
{ * }

sub gdaui_set_source_set_shown_columns (
  GdauiSetSource $s,
  CArray[gint]   $columns, 
  gint           $n_columns
)
  is native(gdaui)
  is export
{ * }

sub gdaui_set_source_set_source (GdauiSetSource $s, GdaSetSource $source)
  is native(gdaui)
  is export
{ * }
