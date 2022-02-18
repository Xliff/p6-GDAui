use v6.c;

use GDA::UI::Raw::Types;
use GDA::UI::Raw::Set;

use GDA::Data::Source;
use GDA::Set;

use GLib::Roles::Object;
use GDA::UI::Roles::Signals::Set;

# BOXED
class GDA::UI::Set::Group {
  also does GLib::Roles::Implementor;

  has GdauiSetGroup $!gusg is implementor;

  submethod BUILD ( :$gda-ui-set-group ) {
    $!gusg = $gda-ui-set-group
  }

  method GDA::UI::Raw::Structs::GdauiSetGroup
    is also<GdauiSetGroup>
  { $!gusg }

  multi method new (GdauiSetGroup $gda-ui-set-group, :$ref = True) {
    return Nil unless $gda-ui-set-group;

    my $o = self.bless( :$gda-ui-set-group )
    $o.ref if $ref;
    $o;
  }
  method new {
    my $gda-ui-set-group = gdaui_set_group_new();

    $gda-ui-set-group ?? self.bless( :$gda-ui-set-group ) !! Nil;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gdaui_set_group_copy($!gusg),
      $raw,
      self.getTypePair
    );
  }

  method free {
    gdaui_set_group_free($!gusg);
  }

  method get_group ( :$raw = False ) {
    propReturnObject(
      gdaui_set_group_get_group($!gusg),
      $raw,
      |GDA::Set::Group.getTypePair
    );
  }

  method get_source ( :$raw = False ) {
    propReturnObject(
      gdaui_set_group_get_source($!gusg),
      $raw,
      |GDA::Data::Source.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_set_group_get_type, $n, $t );
  }

  method set_group (GdaSetGroup() $group) {
    gdaui_set_group_set_group($!gusg, $group);
  }

  method set_source (GdauiSetSource() $source) {
    gdaui_set_group_set_source($!gusg, $source);
  }
  
}

our subset GdauiSetAncestry is export of Mu
  where GdauiSet | GObject;

class GDA::UI::Set {
  also does GLib::Roles::Object;
  also does GDA::UI::Roles::Signals::Set;

  has GdauiSet $!gus is implementor;

  submethod BUILD ( :$gda-ui-set ) {
    self.setGdauiSet($gda-ui-set) if $gda-ui-set;
  }

  method setGdauiSet (GdauiSetAncestry $_) {
    my $to-parent;

    $!gus = do {
      when GdauiDataStore {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdauiSet, $_);
      }
    }

    self!setObject($to-parent);
  }

  method GDA::UI::Raw::Structs::GdauiDataStore
    is also<GdauiDataStore>
  { $!gus }

  multi method new (GdauiSetAncestry $gda-ui-set, :$ref = True) {
    return Nil unless $gda-ui-set;

    my $o = self.bless( :$gda-ui-set )
    $o.ref if $ref;
    $o;
  }
  method new (GDASet() $set) {
    my $gda-ui-set = gdaui_set_new($set);

    $gda-ui-set ?? self.bless( :$gda-ui-set ) !! Nil;
  }

  # Is originally:
  # GdauiSet *set,
  method public-data-changed {
    self.connect-set($!gus, 'public-data-changed');
  }

  # Is originally:
  # GdauiSet *set, GdauiSetSource *source --> void
  method source-model-changed {
    self.connect-source-model-changed($!gus);
  }


  method get_group (GdaHolder() $holder, :$raw = False) {
    propReturnObject(
      gdaui_set_get_group($!gus, $holder),
      $raw,
      |GDA::UI::Set::Group
    )
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_set_get_type, $n, $t );
  }

}

# BOXED
class GDA::UI::Set::Source {
  also does GLib::Roles::Implementor;

  has GdauiSetSource $!guss is implementor;

  submethod BUILD ( :$gda-ui-set-source ) {
    $!guss = $gda-ui-set-source
  }

  method GDA::Raw::Definition::GdauiSetSource
    is also<GdauiSetSource>
  { $!guss }

  multi method new (GdauiSetSourceAncestry $gda-ui-set-source, :$ref = True) {
    return Nil unless $gda-ui-set-source;

    my $o = self.bless( :$gda-ui-set-source );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdaSetSource() $source) {
    my $gdaui-set-source = gdaui_set_source_new($source);

    $gdaui-set-source ?? self.bless( :$gdaui-set-source ) !! Nil;
  }

  method copy (:$raw = False) {
    propReturnObject(
      gdaui_set_source_copy($!gus),
      $raw,
      |self.getTypePair
    );
  }

  method free {
    gdaui_set_source_free($!guss);
  }

  method get_ref_columns ( :$raw = False ) {
    my $ca = gdaui_set_source_get_ref_columns($!guss);

    return $ca if $raw;

    CArrayToArray($ca);
  }

  method get_ref_n_cols  {
    gdaui_set_source_get_ref_n_cols($!guss);
  }

  method get_shown_columns ( :$raw = False ) {
    my $ca = gdaui_set_source_get_shown_columns($!guss);

    return $ca if $raw;

    CArrayToArray($ca);
  }

  method get_shown_n_cols {
    gdaui_set_source_get_shown_n_cols($!guss);
  }

  method get_source ( :$raw = False ) {
    propReturnObject(
      gdaui_set_source_get_source($!guss),
      $raw,
      |GDA::Set::Source.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_set_source_get_type, $n, $t );
  }

  proto method set_ref_columns (|)
  { * }

  multi method set_ref_columns (@columns) {
    samewith( ArrayToCArray(gint, @columns), @columns.elems );
  }
  multi method set_ref_columns (CArray[gint] $columns, Int() $n_columns) {
    my gint $n = $n_columns;

    gdaui_set_source_set_ref_columns($!guss, $columns, $n);
  }

  proto method set_shown_columns (|)
  { * }

  multi method set_shown_columns (@columns) {
    samewith( ArrayToCArray(gint, @columns), @columns.elems );
  }
  multi method set_shown_columns (CArray[gint] $columns, Int() $n_columns) {
    my gint $n = $n_columns;

    gdaui_set_source_set_shown_columns($!guss, $columns, $n);
  }

  method set_source (GdaSetSource() $source) {
    gdaui_set_source_set_source($!guss, $source);
  }

}
