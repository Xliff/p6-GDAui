use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions;
use GDK::Raw::Structs;
use GTK::Raw::Definitions;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

use GLib::Raw::Object;

unit package GDA::UI::Raw::Structs;

class GdauiBasicForm is repr<CStruct> is export {
	HAS GtkBox   $!object;
	has Pointer  $!priv  ; #= GdauiBasicFormPriv
}

class GdauiCloud is repr<CStruct> is export {
	HAS GtkBox   $!object;
	has Pointer  $!priv  ;
}

class GdauiCombo is repr<CStruct> is export {
	HAS GtkComboBox       $!object;
	has Pointer           $!priv; #= GdauiComboPrivate
}

# class GdauiComboClass is repr<CStruct> is export {
#   HAS GtkComboBoxClass $!parent_class;
# }

class GdauiDataCellRendererBin is repr<CStruct> is export {
	HAS GtkCellRendererPixbuf         $!parent;
	has Pointer                       $!priv  ; #= GdauiDataCellRendererBinPrivate
}

class GdauiDataCellRendererBoolean is repr<CStruct> is export {
	HAS GtkCellRendererToggle             $!parent;
	has Pointer                       $!priv  ; #= GdauiDataCellRendererBooleanPrivate
}

class GdauiDataCellRendererCombo is repr<CStruct> is export {
	HAS GtkCellRendererText           $!parent;
	has Pointer                       $!priv  ; #= GdauiDataCellRendererComboPrivate
}

class GdauiDataCellRendererInfo is repr<CStruct> is export {
	HAS GtkCellRenderer               $!parent;
	has Pointer                       $!priv  ; #= GdauiDataCellRendererInfoPriv
}

class GdauiDataCellRendererPassword is repr<CStruct> is export {
	HAS GtkCellRendererText  $!parent;
	has Pointer              $!priv  ; #= GdauiDataCellRendererPasswordPrivate
}

class GdauiDataCellRendererPict is repr<CStruct> is export {
  HAS GtkCellRendererPixbuf $!parent;
	has Pointer               $!priv  ; #= GdauiDataCellRendererPictPrivate
}

class GdauiDataCellRendererTextual is repr<CStruct> is export {
	HAS GtkCellRendererText   $!parent;
	has Pointer               $!priv  ; #= GdauiDataCellRendererTextualPrivate
}

class GdauiDataFilter is repr<CStruct> is export {
	HAS GtkBox  $!object;
	has Pointer $!priv  ; #= GdauiDataFilterPriv
}

# class GdauiDataFilterClass is repr<CStruct> is export {
#   HAS GtkBoxClass $!parent_class;
# }

class GdauiDataProxyInfo is repr<CStruct> is export {
	HAS GtkBox  $!object;
	has Pointer $!priv  ; #= GdauiDataProxyInfoPriv
}

# class GdauiDataProxyInfoClass is repr<CStruct> is export {
#   HAS GtkBoxClass $!parent_class;
# }

class GdauiDataStore is repr<CStruct> is export {
  HAS GObject $!object;
	has Pointer $!priv  ; #= GdauiDataStorePriv
}

# class GdauiDataStoreClass is repr<CStruct> is export {
#   HAS GObjectClass $!parent_class;
# }

class GdauiDsnSelector is repr<CStruct> is export {
	HAS GdauiCombo $!combo;
	has Pointer    $!priv ; #= GdauiDsnSelectorPrivate
}

# class GdauiDsnSelectorClass is repr<CStruct> is export {
#   HAS GdauiComboClass $!parent_class;
# }

class GdauiEntry is repr<CStruct> is export {
	HAS GtkEntry $!entry;
	has Pointer  $!priv ; #= GdauiEntryPrivate
}

class GdauiEntryShell is repr<CStruct> is export {
	HAS GtkViewport  $!object;
	has Pointer      $!priv  ; #= GdauiEntryShellPriv
}

class GdauiEntryWrapper is repr<CStruct> is export {
  HAS GdauiEntryShell $!object;
	has Pointer         $!priv  ; #= GdauiEntryWrapperPriv
}

class GdauiEntryBin is repr<CStruct> is export {
  HAS GdauiEntryWrapper $!object;
	has Pointer           $!priv  ; #= GdauiEntryBinPrivate
}

# class GdauiEntryBinClass is repr<CStruct> is export {
#   HAS GdauiEntryWrapperClass $!parent_class;
# }

class GdauiEntryBoolean is repr<CStruct> is export {
  HAS GdauiEntryWrapper $!object;
	has Pointer           $!priv  ; #= GdauiEntryBooleanPrivate
}

# class GdauiEntryBooleanClass is repr<CStruct> is export {
#   HAS GdauiEntryWrapperClass $!parent_class;
# }

class GdauiEntryCidr is repr<CStruct> is export {
  HAS GdauiEntryWrapper $!object;
	has Pointer           $!priv  ; #= GdauiEntryCidrPrivate
}

# class GdauiEntryCidrClass is repr<CStruct> is export {
#   HAS GdauiEntryWrapperClass $!parent_class;
# }

class GdauiEntryCombo is repr<CStruct> is export {
  HAS GdauiEntryShell $!object;
	has Pointer         $!priv  ; #= GdauiEntryComboPriv
}

# class GdauiEntryComboClass is repr<CStruct> is export {
#   HAS GdauiEntryShellClass $!parent_class;
# }

class GdauiEntryCommonTime is repr<CStruct> is export {
  HAS GdauiEntryWrapper $!object;
	has Pointer           $!priv  ; #= GdauiEntryCommonTimePrivate
}

# class GdauiEntryCommonTimeClass is repr<CStruct> is export {
#   HAS GdauiEntryWrapperClass $!parent_class;
# }

class GdauiEntryDate is repr<CStruct> is export {
  has GdauiEntryCommonTime $!object;
}

# class GdauiEntryDateClass is repr<CStruct> is export {
#   HAS GdauiEntryCommonTimeClass $!parent_class;
# }

class GdauiEntryFilesel is repr<CStruct> is export {
	HAS GdauiEntryWrapper    $!object;
	has Pointer           $!priv  ; #= GdauiEntryFileselPrivate
}

# class GdauiEntryFileselClass is repr<CStruct> is export {
#   HAS GdauiEntryWrapperClass $!parent_class;
# }

class GdauiEntryFormat is repr<CStruct> is export {
  HAS GdauiEntryWrapper $!object;
	has Pointer           $!priv  ; #= GdauiEntryFormatPrivate
}

# class GdauiEntryFormatClass is repr<CStruct> is export {
#   HAS GdauiEntryWrapperClass $!parent_class;
# }

class GdauiEntryNone is repr<CStruct> is export {
  HAS GdauiEntryWrapper $!object;
	has Pointer           $!priv  ; #= GdauiEntryNonePrivate
}

# class GdauiEntryNoneClass is repr<CStruct> is export {
#   HAS GdauiEntryWrapperClass $!parent_class;
# }

class GdauiEntryNumber is repr<CStruct> is export {
  HAS GdauiEntryWrapper $!object;
	has Pointer           $!priv  ; #= GdauiEntryNumberPrivate
}

# class GdauiEntryNumberClass is repr<CStruct> is export {
#   HAS GdauiEntryWrapperClass $!parent_class;
# }

class GdauiEntryPassword is repr<CStruct> is export {
	HAS GdauiEntryWrapper  $!object;
	has Pointer            $!priv  ; #= GdauiEntryPasswordPrivate
}

# class GdauiEntryPasswordClass is repr<CStruct> is export {
#   HAS GdauiEntryWrapperClass $!parent_class;
# }

class GdauiEntryPict is repr<CStruct> is export {
	HAS GdauiEntryWrapper  $!object;
	has Pointer            $!priv  ; #= GdauiEntryPictPrivate
}

# class GdauiEntryPictClass is repr<CStruct> is export {
#   HAS GdauiEntryWrapperClass $!parent_class;
# }

class GdauiEntryRt is repr<CStruct> is export {
  HAS GdauiEntryWrapper $!object;
	has Pointer           $!priv  ; #= GdauiEntryRtPrivate
}

# class GdauiEntryRtClass is repr<CStruct> is export {
#   HAS GdauiEntryWrapperClass $!parent_class;
# }

# class GdauiEntryShellClass is repr<CStruct> is export {
#   HAS GtkViewportClass $!parent_class;
# }

class GdauiEntryString is repr<CStruct> is export {
  HAS GdauiEntryWrapper $!object;
	has Pointer           $!priv  ; #= GdauiEntryStringPrivate
}

# class GdauiEntryStringClass is repr<CStruct> is export {
#   HAS GdauiEntryWrapperClass $!parent_class;
# }

class GdauiEntryText is repr<CStruct> is export {
  HAS GdauiEntryWrapper $!object;
	has Pointer           $!priv  ; #= GdauiEntryTextPrivate
}

# class GdauiEntryTextClass is repr<CStruct> is export {
#   HAS GdauiEntryWrapperClass $!parent_class;
# }

class GdauiEntryTime is repr<CStruct> is export {
  HAS GdauiEntryCommonTime $!object;
}

# class GdauiEntryTimeClass is repr<CStruct> is export {
#   HAS GdauiEntryCommonTimeClass $!parent_class;
# }

class GdauiEntryTimestamp is repr<CStruct> is export {
  HAS GdauiEntryCommonTime $!object;
}

# class GdauiEntryTimestampClass is repr<CStruct> is export {
#   HAS GdauiEntryCommonTimeClass $!parent_class;
# }

class GdauiForm is repr<CStruct> is export {
	HAS GtkBox  $!object;
	has Pointer $!priv  ; #= GdauiFormPriv
}

# class GdauiFormClass is repr<CStruct> is export {
#   HAS GtkBoxClass $!parent_class;
# }

class GdauiFormattedEntry is repr<CStruct> is export {
	HAS GdauiEntry $!entry;
	has Pointer    $!priv ; #= GdauiFormattedEntryPrivate
}

# class GdauiFormattedEntryClass is repr<CStruct> is export {
#   HAS GdauiEntryClass $!parent_class;
# }

class GdauiGrid is repr<CStruct> is export {
	HAS GtkBox  $!object;
	has Pointer $!priv  ; #= GdauiGridPriv
}

# class GdauiGridClass is repr<CStruct> is export {
#   HAS GtkBoxClass $!parent_class;
# }

class GdauiLogin is repr<CStruct> is export {
	HAS GtkBox  $!parent;
	has Pointer $!priv  ; #= GdauiLoginPrivate
}

class GdauiNumericEntry is repr<CStruct> is export {
	HAS GdauiEntry               $!entry;
	has Pointer $!priv ; #= GdauiNumericEntryPrivate
}

# class GdauiNumericEntryClass is repr<CStruct> is export {
#   HAS GdauiEntryClass $!parent_class;
# }

class GdauiProviderAuthEditor is repr<CStruct> is export {
	HAS GtkBox  $!box ;
	has Pointer $!priv; #= GdauiProviderAuthEditorPrivate
}

class GdauiProviderSelector is repr<CStruct> is export {
  HAS GdauiCombo $!parent;
	has Pointer    $!priv  ; #= GdauiProviderSelectorPrivate
}

# class GdauiProviderSelectorClass is repr<CStruct> is export {
#   HAS GdauiComboClass $!parent_class;
# }

class GdauiProviderSpecEditor is repr<CStruct> is export {
	HAS GtkBox  $!box ;
	has Pointer $!priv; #= GdauiProviderSpecEditorPrivate
}

class GdauiRawForm is repr<CStruct> is export {
	HAS GdauiBasicForm  $!object;
	has Pointer         $!priv  ; #= GdauiRawFormPriv
}

# class GdauiRawFormClass is repr<CStruct> is export {
#   HAS GdauiBasicFormClass $!parent_class;
# }

class GdauiRawGrid is repr<CStruct> is export {
	HAS GtkTreeView  $!object;
	has Pointer      $!priv  ; #= GdauiRawGridPriv
}

class GdauiRtEditor is repr<CStruct> is export {
	HAS GtkBox  $!object;
	has Pointer $!priv  ; #= GdauiRtEditorPriv
}

class GdauiServerOperation is repr<CStruct> is export {
	HAS GtkBox  $!object;
	has Pointer $!priv  ; #= GdauiServerOperationPriv
}

# class GdauiServerOperationClass is repr<CStruct> is export {
#   HAS GtkBoxClass $!parent_class;
# }

class GdauiSet is repr<CStruct> is export {
  HAS GObject $!object      ;
	has Pointer $!priv        ; #= GdauiSetPriv
	has GSList  $!sources_list;
	has GSList  $!groups_list ;
}

class GdauiTreeStore is repr<CStruct> is export {
	HAS GObject            $!object;
	has Pointer $!priv  ; #= GdauiTreeStorePriv
}

class PopupContainer is repr<CStruct> is export {
  HAS GtkWindow $!parent;
	has Pointer   $!priv  ; #= PopupContainerPrivate
}

# class PopupContainerClass is repr<CStruct> is export {
#   HAS GtkWindowClass $!parent_class;
# }

class WidgetEmbedder is repr<CStruct> is export {
	has GtkContainer $!container       ;
	has GtkWidget    $!child           ;
	has GdkWindow    $!offscreen_window;
	has gboolean     $!valid           ;
	has gdouble      $!red             ;
	has gdouble      $!green           ;
	has gdouble      $!blue            ;
	has gdouble      $!alpha           ;
}

# class WidgetEmbedderClass is repr<CStruct> is export {
#   HAS GtkContainerClass $!parent_class;
# }

class GdauiSetSource is repr<CStruct> is export {
  has GdaSetSource  $.source;
  has gint          $.show_n_cols;
  has CArray[gint]  $.show_cols_index;              #= Pointer?
  has gint          $.ref_n_cols;
  has CArray[gint]  $.ref_cols_index;               #= Pointer?
  HAS gpointer      @.reserved[4]       is CArray;
}

class GdauiSetGroup is repr<CStruct> is export {
  has GdaSetGroup    $.group;
  has GdauiSetSource $.source-ui;
  HAS gpointer       @.reserved[2]      is CArray;
}
