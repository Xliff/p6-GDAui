use v6.c;

use GLib::Raw::Definitions;

use GTK::Raw::Widget;
use GTK::Raw::Enums;

use GDA;
use GDA::Set;
use GTK::Application;
use GTK::Box;
use GTK::Dialog;
use GTK::Window;
use GTK::Label;
use GDA::Connection;
use GDA::Meta::Store;
use GDA::SQL::Parser;
use GDA::UI;
use GDA::UI::BasicForm;

my $dirname = '.'.IO;

sub demo-find-file ($f, :$fatal = True) {
  my $io = $f.IO;
  return $io if $io.r;

  $io = $dirname.add($f);
  if $fatal {
    die "Cannot find demo file '$f'" unless $io.r;
  }
  $io
}

sub MAIN {
  .init for GDA, GDA::UI;

  # The following C except should be ported
  # cncstring = g_strdup_printf ("DB_DIR=%s;DB_NAME=demo_db", dirname);
  $dirname .= add('examples') unless $dirname.add('demo_db.db').r;

  my $cncstring = "DB_DIR={ $dirname.dirname };DB_NAME=demo_db";
  my $demo-cnc = GDA::Connection.open-from-string('SQlite', $cncstring);
  without $demo-cnc {
    $*ERR.say: "Error opening the connection for file `demo_db.db`: {
      $ERROR && $ERROR.message ?? $ERROR.message !!'No detail' }";
    exit 1;
  }

  # /* Initialize meta store */
  # 	full_filename = demo_find_file ("demo_meta.db", &error);
  # 	if (full_filename)
  # 		mstore = gda_meta_store_new_with_file (full_filename);
  # 	else
  # 		mstore = gda_meta_store_new (NULL);
  # 	g_object_set (G_OBJECT (demo_cnc), "meta-store", mstore, NULL);
  #         g_object_unref (mstore);
  # 	if (! full_filename)
  # 		gda_connection_update_meta_store (demo_cnc, NULL, NULL);
  # 	g_object_set (demo_cnc, "execution-slowdown", 1000000, NULL);
  my $update-meta-store = False;
  $demo-cnc.meta-store = do if demo-find-file("demo_meta.db", :!fatal) -> $f {
    $f.say;
    $update-meta-store = True;
    GDA::Meta::Store.new-with-file($f);
  } else {
    GDA::Meta::Store.new
  }
  $demo-cnc.update-meta-store if $update-meta-store;
  $demo-cnc.execution-slowdown = 1000000;

  # 	/* Initialize parser object */
  # 	demo_parser = gda_connection_create_parser (demo_cnc);
  # 	if (!demo_parser)
  # 		demo_parser = gda_sql_parser_new ();
  # my $demo-parser = $demo-cnc.create-parser;
  # $demo-parser //= GDA::SQL::Parser.new;

  my $app = GTK::Application.new(
    title       => 'org.genex.ui.gda.basicform',
    width       => 800,
    height      => 600
  );

  $app.activate.tap({
    CATCH { default { .message.say; .backtrace.concise.say } }

    $app.wait-for-init;

    my $window = GTK::Dialog.new-with-buttons(
      'GdaUIBasicForm',
      $app.window,
      0,
      Close => GTK_RESPONSE_NONE
    );

    # $window.response.tap(-> *@a { @a.head.destroy   } );
    # $window.destroy.tap( -> *@a { @a.head.destroyed } );

    my $vbox = GTK::Box.new-vbox(5);
    $vbox.border-width = 5;
    $window.get-content-area.pack-start($vbox, True, True);

    my $label = GTK::Label.new( q:to/LABEL/ );
      This example shows 2 GdauiBasicForm widgets operating on the
      same GdaSet. When a value is modified in one form, then it is
      automatically updated in the other form.

      Also the top form uses the default layout, while the bottom one
      uses a custom (2 columns) layout.
      The 'an int' entry is hidden in the top form
      LABEL

    $vbox.pack-start($label);

    # .new-inline shouold take a: Pair, 2 element array, GdaHolder
    my $set = GDA::Set.new-inline(
      [ 'a string', 'A string Value' ],
      [ 'an int',    12              ],
      [ 'a picture', Nil             ]
    );

    my $form = GDA::UI::BasicForm.new($set);
    $vbox.pack-start($form, True, True);
    $form.entry-set-visible( $set.get-holder('an int'), False);

    my $label2 = GTK::Label.new('2nd form is below:');
    $vbox.pack-start($label2);

    my $form2 = GDA::UI::BasicForm.new($set);
    $vbox.pack-start($form2);

    my $filename = demo-find-file('custom_layout.xml');
    $form.set-layout-from-file($filename, 'simple');

    $app.window.show-all;
  });

  $app.run;
}
