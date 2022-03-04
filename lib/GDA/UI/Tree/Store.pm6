use v6.c;

use Method::Also;

use NativeCall;

use GDA::UI::Raw::Types;
use GDA::UI::Raw::Tree::Store;

use GDA::Tree::Node;

use GLib::Roles::Object;
use GTK::Roles::TreeModel;
use GDA::UI::Roles::Signals::Tree::Store;

our subset GdauiTreeStoreAncestry is export of Mu
  where GdauiTreeStore | GtkTreeModel | GObject;

class GDA::UI::Tree::Store {
  also does GLib::Roles::Object;
  also does GTK::Roles::TreeModel;
  also does GDA::UI::Roles::Signals::Tree::Store;

  has GdauiTreeStore $!guts;

  submethod BUILD ( :$gda-ui-tree-store ) {
    self.setGdauiTreeStore($gda-ui-tree-store) if $gda-ui-tree-store;
  }

  method setGdauiTreeStore (GdauiTreeStoreAncestry $_) {
    my $to-parent;

    $!guts = do {
      when GdauiTreeStore {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GtkTreeModel {
        $to-parent = cast(GObject, $_);
        $!tm       = $_;
        cast(GdauiTreeStore, $_);
      }

      default {
        $to-parent = $_;
        cast(GdauiTreeStore, $_);
      }
    }
    self!setObject($to-parent);
    self!roleInit-GtkTreeModel;
  }

  method GDA::Raw::Definition::GdauiTreeStore
    is also<GdauiTreeStore>
  { $!guts }

  proto method new (|)
  { * }

  multi method new (GdauiTreeStoreAncestry  $gda-ui-tree-store,
                                           :$ref      = True
  ) {
    return Nil unless $gda-ui-tree-store;

    my $o = self.bless( :$gda-ui-tree-store );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdaTree() $tree, *%defs) {
    samewith($tree, %defs);
  }
  multi method new (GdaTree() $tree, %defs) {
    # cw: Yes, .keys and .values have been proven to return the same order!
    samewith($tree, %defs.keys, %defs.values);
  }
  multi method new (GdaTree() $tree, @columns, @types) {
    self.newv(
      $tree,
      @columns.elems,
      ArrayToCArray(GType, @types),
      ArrayToCArray(Str, @columns)
    );
  }

  method newv (
    GdaTree()     $tree,
    Int()         $n_columns,
    CArray[GType] $types,
    CArray[Str]   $attribute_names
  ) {
    my GType $t = $types;
    my guint $n = $n_columns;

    die '$types and $attribute_names must be CArrays of the same size!'
      unless $types.elems === $attribute_names.elems;

    die 'Column number must not be less than $n_columns!'
      unless $attribute_names >= $n_columns;

    my $gda-ui-tree-store = gdaui_tree_store_newv(
      $tree,
      $n_columns,
      $types,
      $attribute_names
    );

    $gda-ui-tree-store ?? self.bless( :$gda-ui-tree-store ) !! Nil;
  }

  # Is originally:
  # GdauiTreeStore *store, Str *path --> gboolean
  method drag-delete {
    self.connect-drag($!guts, 'drag-delete');
  }

  # Is originally:
  # GdauiTreeStore *store, Str *path --> gboolean
  method drag-can-drag {
    self.connect-drag($!guts, 'drag-can-drag');
  }

  # Is originally:
  # GdauiTreeStore *store, Str *path, GtkSelectionData *selection_data --> gboolean
  method drag-drop {
    self.connect-dnd($!guts, 'drag-drop');
  }

  # Is originally:
  # GdauiTreeStore *store, Str *path, GtkSelectionData *selection_data --> gboolean
  method drag-can-drop {
    self.connect-dnd($!guts, 'drag-can-drop');
  }

  # Is originally:
  # GdauiTreeStore *store, Str *path, GtkSelectionData *selection_data --> gboolean
  method drag-get {
    self.connect-dnd($!guts, 'drag-get');
  }

  multi method get_iter (GtkTreeIter() $iter, GdaTreeNode() $node)
    is also<get-iter>
  {
    so gdaui_tree_store_get_iter($!guts, $iter, $node);
  }

  method get_iter_from_node (GtkTreeIter() $iter, GdaTreeNode() $node)
    is also<get-iter-from-node>
  {
    so gdaui_tree_store_get_iter_from_node($!guts, $iter, $node);
  }

  method get_node (GtkTreeIter() $iter, :$raw = False) is also<get-node> {
    propReturnObject(
      gdaui_tree_store_get_node($!guts, $iter),
      $raw,
      |GDA::Tree::Node
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_tree_store_get_type, $n, $t );
  }

}
