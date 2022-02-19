use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GDA::Raw::Structs;
use GTK::Raw::Structs;
use GDA::UI::Raw::Definitions;
use GDA::UI::Raw::Structs;

unit package GDA::UI::Raw::Tree::Store;


### /usr/src/libgda5-5.2.10/libgda-ui/gdaui-tree-store.h

sub gdaui_tree_store_get_iter (
  GdauiTreeStore $store,
  GtkTreeIter    $iter,
  GdaTreeNode    $node
)
  returns uint32
  is native(gdaui)
  is export
{ * }

sub gdaui_tree_store_get_iter_from_node (
  GdauiTreeStore $store,
  GtkTreeIter    $iter,
  GdaTreeNode    $node
)
  returns uint32
  is native(gdaui)
  is export
{ * }

sub gdaui_tree_store_get_node (GdauiTreeStore $store, GtkTreeIter $iter)
  returns GdaTreeNode
  is native(gdaui)
  is export
{ * }

sub gdaui_tree_store_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

# cw: var_args out of scope!
#
# sub gdaui_tree_store_new (GdaTree $tree, guint $n_columns, ...)
#   returns GtkTreeModel
#   is native(gdaui)
#   is export
# { * }

sub gdaui_tree_store_newv (
  GdaTree     $tree,
  guint       $n_columns,
  GType       $types,
  CArray[Str] $attribute_names
)
  returns GdauiTreeStore
  is native(gdaui)
  is export
{ * }
