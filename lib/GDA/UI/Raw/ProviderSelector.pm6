use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Structs;
use GDA::UI::Raw::Definitions;
use GDA::UI::Raw::Enums;
use GDA::UI::Raw::Structs;

unit package GDA::UI::Raw::ProviderSelector;

### /usr/src/libgda5-5.2.10/libgda-ui/gdaui-provider-selector.h

sub gdaui_provider_selector_get_provider (GdauiProviderSelector $selector)
  returns Str
  is native(gdaui)
  is export
{ * }

sub gdaui_provider_selector_get_provider_obj (GdauiProviderSelector $selector)
  returns GdaServerProvider
  is native(gdaui)
  is export
{ * }

sub gdaui_provider_selector_get_type ()
  returns GType
  is native(gdaui)
  is export
{ * }

sub gdaui_provider_selector_new ()
  returns GdauiProviderSelector
  is native(gdaui)
  is export
{ * }

sub gdaui_provider_selector_set_provider (
  GdauiProviderSelector $selector,
  Str                   $provider
)
  returns uint32
  is native(gdaui)
  is export
{ * }
