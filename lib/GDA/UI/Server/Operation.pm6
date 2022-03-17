use v6.c;

use Method::Also;

use NativeCall;

use GDA::UI::Raw::Types;

use GTK::Box;

our subset GdauiServerOperationAncestry is export of Mu
  where GdauiServerOperation | GtkBoxAncestry;

class GDA::UI::Server::Operation is GTK::Box {
  has GdauiServerOperation $!guso is implementor;

  submethod BUILD( :$gda-server-operation ) {
    self.setGdauiServerOperation($gda-server-operation)
      if $gda-server-operation;
  }

  method setGdauiServerOperation (GdauiServerOperationAncestry $_) {
    my $to-parent;

    $!guso = do {
      when GdauiServerOperation {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdauiServerOperation, $_);
      }
    }
    self.setBox($to-parent);
  }

  method GDA::Raw::Definitions::GdauiServerOperation
    is also<GdauiServerOperation>
  { $!guso }

  proto method new (|)
  { * }

  multi method new (
    GdauiServerOperationAncestry  $gda-server-operation,
                                 :$ref             = True
  ) {
    return Nil unless $gda-server-operation;

    my $o = self.bless(:$gda-server-operation);
    $o.ref if $ref;
    $o;
  }
  multi method new (GdaServerOperation() $op) {
    my $gdaui-server-operation = gdaui_server_operation_new($op);

    $gdaui-server-operation ?? self.bless( :$gdaui-server-operation ) !! Nil;
  }

  method new_in_dialog (
    GdaServerOperation() $op,
    GtkWindow()          $parent,
    Str()                $title,
    Str()                $header
  )
    is also<new-in-dialog>
  {
    my $gdaui-server-operation = gdaui_server_operation_new_in_dialog(
      $op,
      $parent,
      $title,
      $header
    );

    $gdaui-server-operation ?? self.bless( :$gdaui-server-operation ) !! Nil;
  }

  # Type: GdauiServerOperation
  method server-operation ( :$raw = False ) is rw  is also<server_operation> {
    my $gv = GLib::Value.new( GDA::Server::Operation.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('server-operation', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Server::Operation.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'server-operation is a construct-only attribute'
      }
    );
  }


  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_server_operation_get_type, $n, $t );
  }

}


### /usr/src/libgda5-5.2.10/libgda-ui/gdaui-server-operation.h

sub gdaui_server_operation_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_server_operation_new (GdaServerOperation $op)
  returns GdauiServerOperation
  is native(gdaui)
  is export
{ * }

sub gdaui_server_operation_new_in_dialog (
  GdaServerOperation $op,
  GtkWindow          $parent,
  Str                $title,
  Str                $header
)
  returns GtkWidget
  is native(gdaui)
  is export
{ * }
