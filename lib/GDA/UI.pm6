use v6.c;

use NativeCall;

use GDA::UI::Raw::Definitions;

use GLib::Roles::StaticClass;

class GDA::UI {
  also does GLib::Roles::StaticClass;

  method init {
    gdaui_init();
  }

}

### /usr/include/libgda-5.0/libgda/libgda-ui.h

sub gdaui_init ()
  is native(gdaui)
  is export
{ * }
