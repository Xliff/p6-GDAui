use v6.c; 

use GLib::Raw::Definitions;

unit package GDA::UI::Raw::Enums;

constant GdaDataStoreCol is export := gint32;
our enum GdaDataStoreColEnum is export (
  GDAUI_DATA_STORE_COL_MODEL_N_COLUMNS => -2,
  DATA_STORE_COL_MODEL_N_COLUMNS       => -2,
  GDAUI_DATA_STORE_COL_MODEL_POINTER   => -3,
  DATA_STORE_COL_MODEL_POINTER         => -3,
  GDAUI_DATA_STORE_COL_MODEL_ROW       => -4,
  DATA_STORE_COL_MODEL_ROW             => -4,
  GDAUI_DATA_STORE_COL_MODIFIED        => -5,
  DATA_STORE_COL_MODIFIED              => -5,
  GDAUI_DATA_STORE_COL_TO_DELETE       => -6,
  DATA_STORE_COL_TO_DELETE             => -6,
);

constant GdauiAction is export := guint32;
our enum GdauiActionEnum is export <
  GDAUI_ACTION_NEW_DATA
  GDAUI_ACTION_WRITE_MODIFIED_DATA
  GDAUI_ACTION_DELETE_SELECTED_DATA
  GDAUI_ACTION_UNDELETE_SELECTED_DATA
  GDAUI_ACTION_RESET_DATA
  GDAUI_ACTION_MOVE_FIRST_RECORD
  GDAUI_ACTION_MOVE_PREV_RECORD
  GDAUI_ACTION_MOVE_NEXT_RECORD
  GDAUI_ACTION_MOVE_LAST_RECORD
  GDAUI_ACTION_MOVE_FIRST_CHUNCK
  GDAUI_ACTION_MOVE_PREV_CHUNCK
  GDAUI_ACTION_MOVE_NEXT_CHUNCK
  GDAUI_ACTION_MOVE_LAST_CHUNCK
>;

constant GdauiActionMode is export := guint32;
our enum GdauiActionModeEnum is export (
  GDAUI_ACTION_NAVIGATION_ARROWS      => 1 +< 0,
  GDAUI_ACTION_NAVIGATION_SCROLL      => 1 +< 1,
  GDAUI_ACTION_MODIF_AUTO_COMMIT      => 1 +< 2,
  GDAUI_ACTION_MODIF_COMMIT_IMMEDIATE => 1 +< 3,
  GDAUI_ACTION_ASK_CONFIRM_UPDATE     => 1 +< 4,
  GDAUI_ACTION_ASK_CONFIRM_DELETE     => 1 +< 5,
  GDAUI_ACTION_ASK_CONFIRM_INSERT     => 1 +< 6,
  GDAUI_ACTION_REPORT_ERROR           => 1 +< 7,
);

constant GdauiBasicFormPart is export := guint32;
our enum GdauiBasicFormPartEnum is export <
  GDAUI_BASIC_FORM_LABELS
  GDAUI_BASIC_FORM_ENTRIES
>;

constant GdauiDataEntryError is export := guint32;
our enum GdauiDataEntryErrorEnum is export <
  GDAUI_DATA_ENTRY_FILE_NOT_FOUND_ERROR
  GDAUI_DATA_ENTRY_INVALID_DATA_ERROR
>;

constant GdauiDataProxyInfoFlag is export := guint32;
our enum GdauiDataProxyInfoFlagEnum is export (
  GDAUI_DATA_PROXY_INFO_NONE                  =>      0,
  GDAUI_DATA_PROXY_INFO_CURRENT_ROW           => 1 +< 0,
  GDAUI_DATA_PROXY_INFO_ROW_MODIFY_BUTTONS    => 1 +< 2,
  GDAUI_DATA_PROXY_INFO_ROW_MOVE_BUTTONS      => 1 +< 3,
  GDAUI_DATA_PROXY_INFO_CHUNCK_CHANGE_BUTTONS => 1 +< 4,
  GDAUI_DATA_PROXY_INFO_NO_FILTER             => 1 +< 5,
);

constant GdauiDataProxyWriteMode is export := guint32;
our enum GdauiDataProxyWriteModeEnum is export (
  GDAUI_DATA_PROXY_WRITE_ON_DEMAND          => 0,
  GDAUI_DATA_PROXY_WRITE_ON_ROW_CHANGE      => 1,
  GDAUI_DATA_PROXY_WRITE_ON_VALUE_ACTIVATED => 2,
  GDAUI_DATA_PROXY_WRITE_ON_VALUE_CHANGE    => 3,
);

constant GdauiLoginMode is export := guint32;
our enum GdauiLoginModeEnum is export (
  GDA_UI_LOGIN_ENABLE_CONTROL_CENTRE_MODE  => 1 +< 0,
  GDA_UI_LOGIN_HIDE_DSN_SELECTION_MODE     => 1 +< 1,
  GDA_UI_LOGIN_HIDE_DIRECT_CONNECTION_MODE => 1 +< 2,
);

constant PictEncodeType is export := guint32;
our enum PictEncodeTypeEnum is export <
  ENCODING_NONE
  ENCODING_BASE64
>;
