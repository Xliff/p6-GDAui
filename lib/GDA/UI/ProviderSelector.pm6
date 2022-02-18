use v6.c;

use Method::Also;

use GDA::UI::Raw::Types;
use GDA::UI::Raw::ProviderSelector;

use GDA::UI::Combo;

our subset GdauiProviderSelectorAncestry is export of Mu
  where GdauiProviderSelector | GdauiComboAncestry;

class GDA::UI::ProviderSelector is GDA::UI::Combo {
  has GdauiProviderSelector $!gups is implementor;

  submethod BUILD ( :$gdai-ui-provider-selector ) {
    self.setGdauiProviderSelector($gdai-ui-provider-selector)
      if $gdai-ui-provider-selector;
  }

  method setGdauiProviderSelector (GdauiProviderSelectorAncestry $_) {
    my $to-parent;

    $!gups = do {
      when GdauiProviderSelector {
        $to-parent = cast(GdauiCombo, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdauiProviderSelector, $_);
      }
    }
    self.setGdauiCombi($to-parent);
  }

  method GDA::UI::Raw::Structs::GdauiProviderSelector
    is also<GdauiProviderSelector>
  { $!gups }

  multi method new (
    GdauiProviderSelectorAncestry  $gdai-ui-provider-selector,
                                  :$ref                        = True
  ) {
    return Nil unless $gdai-ui-provider-selector;

    my $o = self.bless( :$gdai-ui-provider-selector );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $gdai-ui-provider-selector = gdaui_provider_selector_new();

    $gdai-ui-provider-selector ?? self.bless( :$gdai-ui-provider-selector )
                               !! Nil;
  }

  method get_provider is also<get-provider> {
    gdaui_provider_selector_get_provider($!gups);
  }

  method get_provider_obj ( :$raw = False ) is also<get-provider-obj> {
    propReturnObject(
      gdaui_provider_selector_get_provider_obj($!gups),
      $raw,
      |GDA::Server::Provider.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdaui_provider_selector_get_type, $n, $t );
  }

  method set_provider (Str() $provider) is also<set-provider> {
    gdaui_provider_selector_set_provider($!gups, $provider);
  }

}
