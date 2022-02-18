use v6.c;

use Method::Also;
use NativeCall;

use GDA::UI::Raw::Types;
use GDA::UI::Raw::Data::Store;

use GDA::Data::Proxy;

use GLib::Roles::Object;
use GTK::Roles::TreeModel;

our subset GdauiDataStoreAncestry is export of Mu
  where GdauiDataStore | GtkTreeModel | GObject;

class GDA::UI::Data::Store {
  also does GLib::Roles::Object;
  also does GTK::Roles::TreeModel;

  has GdauiDataStore $!guds is implementor;

  submethod BUILD ( :$gdaui-data-store ) {
    self.setGdauiDataStore($gdaui-data-store) if $gdaui-data-store;
  }

  method setGdauiDataStore (GdauiDataStoreAncestry $_) {
    my $to-parent;

    $!guds = do {
      when GdauiDataStore {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GtkTreeModel {
        $!tm = $_;
        $to-parent = cast(GObject, $_);
        cast(GdauiDataStore, $_);
      }

      default {
        $to-parent = $_;
        cast(GdauiDataStore, $_);
      }
    }

    self!setObject($to-parent);
    $!tm //= cast(GtkTreeModel, $_);
  }

  method GDA::UI::Raw::Structs::GdauiDataStore
    is also<GdauiDataStore>
  { $!guds }

  multi method new (GdauiDataStoreAncestry $gdaui-data-store, :$ref = True) {
    return Nil unless $gdaui-data-store;

    my $o = self.bless( :$gdaui-data-store );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdaDataModel() $model) {
    my $gdaui-data-store = gdaui_data_store_new($model);

    $gdaui-data-store ?? self.bless( :$gdaui-data-store ) !! Nil;
  }

  # Type: pointer
  method model is rw  {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('model', $gv)
        );
        $gv.pointer
      },
      STORE => -> $, $val is copy {
        $gv.pointer = $val;
        self.prop_set('model', $gv);
      }
    );
  }

  # Type: boolean
  method prepend-null-entry is rw  is also<prepend_null_entry> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('prepend-null-entry', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('prepend-null-entry', $gv);
      }
    );
  }

  # Type: pointer
  method proxy is rw  {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('proxy', $gv)
        );
        $gv.pointer
      },
      STORE => -> $, $val is copy {
        warn 'proxy does not allow writing'
      }
    );
  }

  method append (GtkTreeIter() $iter) {
    gdaui_data_store_append($!guds, $iter);
  }

  method delete (GtkTreeIter() $iter) {
    gdaui_data_store_delete($!guds, $iter);
  }

  proto method get_iter_from_values (|)
    is also<get-iter-from-values>
  { * }

  multi method get_iter_from_values (
    GSList()       $values,                        # a GSList of GValues
                   @cols_index,
    GtkTreeIter() :$iter        = GtkTreeIter.new
  ) {
    my $rv = samewith( $iter, $values, ArrayToCArray(gint, @cols_index) );

    $rv ?? $iter !! Nil;
  }
  multi method get_iter_from_values (
    GtkTreeIter() $iter,
    GSList()      $values,
    CArray[gint]  $cols_index
  ) {
    so gdaui_data_store_get_iter_from_values(
      $!guds,
      $iter,
      $values,
      $cols_index
    );
  }

  method get_proxy ( :$raw = False ) is also<get-proxy> {
    propReturnObject(
      gdaui_data_store_get_proxy($!guds),
      $raw,
      |GDA::Data::Proxy.getTypePair
    );
  }

  method get_row_from_iter (GtkTreeIter() $iter) is also<get-row-from-iter> {
    gdaui_data_store_get_row_from_iter($!guds, $iter);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_data_store_get_type, $n, $t );
  }

  method set_value (GtkTreeIter() $iter, gint() $col, GValue() $value)
    is also<set-value>
  {
    so gdaui_data_store_set_value($!guds, $iter, $col, $value);
  }

  method undelete (GtkTreeIter() $iter) {
    gdaui_data_store_undelete($!guds, $iter);
  }

}
