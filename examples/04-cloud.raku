use v6.c;

use GDA::UI::Raw::Types;

use GDA;
use GTK::Application;
use GTK::Box;
use GTK::Entry;
use GTK::Label;
use GTK::RadioButton;
use GTK::Widget;
use GDA::UI::BasicForm;
use GDA::UI::Cloud;

use GDAUIScripts;

sub MAIN {
  my $app = GTK::Application.new(
    title  => 'org.genex.gda.ui.cloud',
    width  => 640,
    height => 480
  );

  $app.activate.tap( -> *@a {
    CONTROL {
      when CX::Warn {
        .message.say;
        .backtrace.concise.say;
        .resume;
      }
      default       { .rethrow }
    }
    $app.wait-for-init;

    open-demo-connection;

    my $vbox = GTK::Box.new-vbox(5);
    $app.window.add($vbox);
    $vbox.border-width = 5;

    my $label = GTK::Label.new( q:to/BOX/ );
      The followin GdauiCloud widget displays customers,
      appearing bigger if they made more purchases.
      BOX

    $vbox.pack-start($label);

    # Create demo widget
    my $stmt = $demo-parser.parse-string( q:to/SQL/ );
      SELECT c.id, c.name, count(o.id) AS weight
      FROM customers c
      LEFT JOIN orders o on (c.id=o.customer)
      GROUP BY c.name
      ORDER BY c.name
      SQL

    say "D: $demo-cnc";

    my $model = $demo-cnc.statement-execute-select($stmt);

    say "M: { $model // '»UNDEF«'}";

    my $cloud = GDA::UI::Cloud.new($model, 1, 2);
    $vbox.pack-start($cloud, True, True);

    # Create search box
    my $search = $cloud.create-filter-widget;
    $vbox.pack-start($search);

    $label = GTK::Label.new('Selection mode:');
    $vbox.pack-start($label);

    my @rbs = GTK::RadioButton.new-group(
      GtkSelectionModeEnum.pairs.sort( *.value ).map( *.key )
    );
    for @rbs {
      my $radio-button = $_;

      $radio-button.toggled.tap( -> *@a {
        $cloud.set-selection-mode(
          ::($radio-button.label) 
        ) if $radio-button.active
      });
      $vbox.pack-start($_);
    }

    # Selection
    $label = GTK::Label.new('Current selection is:');
    $vbox.pack-start($label);
    my $form = GDA::UI::BasicForm.new($cloud.get_data_set);
    $vbox.pack-start($form);

    $cloud.selection-changed.tap(-> *@a ($data-sel) {
      CONTROL {
        when CX::Warn {
          .message.say;
          .backtrace.concise.say;
          .resume;
        }
      }
      CATCH {
        default { .message.say; .backtrace.concise.say }
      }

      my $str-sel = do if $data-sel.get_selected_rows -> $sel {
        $sel.Array.join(', ');
      }
      say "Selection changed: { $str-sel // '' }";
    });

    # Force selection
    $label = GTK::Label.new('Selection forcing:');
    $vbox.pack-start($label);

    my $hbox = GTK::Box.new-hbox;
    $vbox.pack-start($hbox);
    $label = GTK::Label.new('row number:');
    $hbox.pack-start($label);
    my $entry = GTK::Entry.new;
    $hbox.pack-start($entry);

    $hbox = GTK::Box.new-hbox(0);
    $vbox.pack-start($hbox);
    my $button1 = GTK::Button.new-with-label('Force select:');
    $hbox.pack-start($button1);
    $button1.data<entry> = $entry;
    $button1.clicked.tap(-> *@a {
      say 'button1.clicked...';

      my $r = $button1.data<entry>.text;
      say "Row selected { $r }: {
           $cloud.select_row($r) ?? 'OK' !! 'Error' }";
    });

    $hbox = GTK::Box.new-hbox(0);
    $vbox.pack-start($hbox);
    my $button2 = GTK::Button.new-with-label('Force UNselect:');
    $hbox.pack-start($button2);
    $button2.data<entry> = $entry;
    $button2.clicked.tap(-> *@a {
      say 'button2.clicked...';

      say "Row UNselected { $button2.data<entry>.text }";
    });

    $app.window.show-all;
  });

  $app.run;
}
