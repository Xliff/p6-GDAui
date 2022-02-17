use v6.c;

unit package GDA::UI::Raw::Exports;

our @gda-ui-exports is export;

BEGIN {
  @gda-ui-exports = <
    GDA::UI::Raw::Definitions
    GDA::UI::Raw::Enums
    GDA::UI::Raw::Structs
  >;
}
