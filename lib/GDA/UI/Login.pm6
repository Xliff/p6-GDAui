use v6.c;

use GDA::UI::Raw::Types;
use GDA::UI::Raw::Login;

use GTK::Box;

use GDA::UI::Roles::Signals::Login;

our subset GdauiLoginAncestry is export of Mu
  where GdauiLogin | GtkBoxAncestry;

class GDA::UI::Login is GTK::Box {
  also does GDA::UI::Roles::Signals::Login;

  has GdauiLogin $!gul;

  submethod BUILD ( :$gdaui-login ) {
    self.setGdauiLogin($gdaui-login) if $gdaui-login;
  }

  method setGdauiLogin (GdauiLoginAncestry $_) {
    my $to-parent;

    $!gul = do {
      when GdauiLogin {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdauiLogin, $_);
      }
    }

    self.setGtkBox($to-parent);
  }

  method GDA::UI::Raw::Structs::GdauiLogin
  { $!gul }

  method new (Str() $dsn) {
    my $gdaui-login = gdaui_login_new($dsn);

    $gdaui-login ?? self.bless( :$gdaui-login ) !! Nil;
  }

  # Is originally:
  # GdauiLogin *login,  gboolean is_valid --> void
  method changed {
    self.connect-changed($!gul);
  }

  method get_connection_information {
    gdaui_login_get_connection_information($!gul);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_login_get_type, $n, $t );
  }

  method set_connection_information (GdaDsnInfo $cinfo) {
    gdaui_login_set_connection_information($!gul, $cinfo);
  }

  method set_dsn (Str() $dsn) {
    gdaui_login_set_dsn($!gul, $dsn);
  }

  method set_mode (Int() $mode) {
    my GdauiLoginMode $m = $mode;

    gdaui_login_set_mode($!gul, $m);
  }
}
