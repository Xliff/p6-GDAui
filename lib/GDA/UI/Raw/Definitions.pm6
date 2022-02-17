use v6.c;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;

use GLib::Roles::Pointers;

unit package GDA::UI::Raw::Definitions;

constant gdaui           is export = 'gda-ui-5.0',v4;

constant GDAUI_COLOR_NORMAL_NULL      is export =  '#00cd66';
constant GDAUI_COLOR_PRELIGHT_NULL    is export =  '#00ef77';
constant GDAUI_COLOR_NORMAL_DEFAULT   is export =  '#6495ed';
constant GDAUI_COLOR_PRELIGHT_DEFAULT is export =  '#75a6fe';
constant GDAUI_COLOR_NORMAL_MODIF     is export =  '#cacaee';
constant GDAUI_COLOR_PRELIGHT_MODIF   is export =  '#cfcffe';
constant GDAUI_COLOR_NORMAL_INVALID   is export =  '#ff6a6a';
constant GDAUI_COLOR_PRELIGHT_INVALID is export =  '#ff7b7b';

class GdauiDataProxy    is repr<CPointer> is export does GLib::Roles::Pointers { }
class GdauiDataSelector is repr<CPointer> is export does GLib::Roles::Pointers { }
