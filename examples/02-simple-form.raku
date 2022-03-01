use v6.c;

use GDA::UI::Raw::Types;

use GDA;
use GDA::Connection;
use GDA::Data::Select;
use GDA::SQL::Parser;
use GTK::Application;
use GTK::Button;
use GDA::UI::Form;

sub say-error ($prefix, :$fatal = True) {
  $*ERR.say: "{ $prefix } { $ERROR.message // 'No detail' }";
  exit(1) if $fatal;
}

sub run-statement ($table, $stmt) {
  unless ( my $data-model = $*cnc.statement-execute-select($stmt) ) {
    say-error("Could not get the contents of the '{ $table }' table:\n\t");
  }

  $data-model.dump_as_string.say;

  GDA::Data::Select.new($data-model.GdaDataModel);
}

sub get-salesrep {
  my $stmt = $*cnc.data<parser>.parse-string(q:to/SQL/) ;
    SELECT id, name
    FROM salesrep
    ORDER BY name
    SQL

  run-statement('salesrep', $stmt);
}

sub get-customers {
  my $stmt = $*cnc.data<parser>.parse-string(q:to/SQL/) ;
    SELECT id, name, default_served_by
    FROM customers
    ORDER BY name
    SQL

  run-statement('customers', $stmt);
}

sub open-connection {
  unless ( my $cnc = GDA::Connection.open-from-dsn('SalesTest') ) {
    say-error('Could not open connection to SalesTest DSN:');
  }

  $cnc.data<parser> = $cnc.create-parser // GDA::SQL::Parser.new;
  $cnc;
}

sub MAIN {
  GDA.init;

  my $app = GTK::Application.new(
    title  => 'org.genex.gda.ui.simple-form',
    width  => 500,
    height => 300
  );

  my $*cnc      = open-connection;
  my $customers = get-customers;
  my $salesrep  = get-salesrep;

  (my $mcontext = GdaMetaContext.new).table-name = '_tables';
  say-error("Can't get meta data:")
    unless $*cnc.update-meta-store($mcontext);
  say-error("Can't make form writeable:")
    unless $customers.compute_modification_statements;

  $app.activate.tap(-> *@a {
    $app.window.border-width = 10;

    my $vbox = GTK::Box.new-vbox(5);
    $app.window.add($vbox);

    my $form = GDA::UI::Form.new($customers);
    $form.set_write_mode(GDAUI_DATA_PROXY_WRITE_ON_VALUE_CHANGE);
    $vbox.pack-start($form, True, True);

    my $iter   = $form.get_data_set;
    my $holder = $iter.get-holder-for-field(2);
    $holder.set-source-model($salesrep, 0);

    my $button = GTK::Button.new-with-label('Quit');
    $vbox.pack-start($button);
    $button.clicked.tap(-> *@a { $app.quit( :gio ) });

    $app.window.show-all;
  });

  $app.run;

  $*cnc.close;
}
