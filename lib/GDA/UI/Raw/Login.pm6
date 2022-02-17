use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Structs;
use GDA::UI::Raw::Definitions;
use GDA::UI::Raw::Enums;
use GDA::UI::Raw::Structs;

unit package GDA::UI::Raw::Login;

### /usr/src/libgda5-5.2.10/libgda-ui/gdaui-login.h

sub gdaui_login_get_connection_information (GdauiLogin $login)
  returns GdaDsnInfo
  is native(gdaui)
  is export
{ * }

sub gdaui_login_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_login_new (Str $dsn)
  returns GdauiLogin
  is native(gdaui)
  is export
{ * }

sub gdaui_login_set_connection_information (
  GdauiLogin $login,
  GdaDsnInfo $cinfo
)
  is native(gdaui)
  is export
{ * }

sub gdaui_login_set_dsn (GdauiLogin $login, Str $dsn)
  is native(gdaui)
  is export
{ * }

sub gdaui_login_set_mode (GdauiLogin $login, GdauiLoginMode $mode)
  is native(gdaui)
  is export
{ * }
