#!/usr/bin/env perl

use PerlLib::SwissArmyKnife;

if (! -f 'OpenFoodToxTX22525_2020.xlsx') {
  system "wget https://zenodo.org/record/3693783/files/OpenFoodToxTX22525_2020.xlsx?download=1";
  system "mv 'OpenFoodToxTX22525_2020.xlsx?download=1' 'OpenFoodToxTX22525_2020.xlsx'";
}
if (! -f 'OpenFoodToxTX22525_2020.csv') {
  system "xlsx2csv -a 'OpenFoodToxTX22525_2020.xlsx' > OpenFoodToxTX22525_2020.csv";
}

my $spreadsheets = [];
my $nextfile;
my @rows = ();

my $c = read_file('OpenFoodToxTX22525_2020.csv');

foreach my $line (split /\n/, $c) {
  if ($line =~ /^-------- (\d+) - (.*?)$/) {
    my $tmp = $2;
    if (scalar @rows) {
      my $fh = IO::File->new();
      $fh->open(">data/$nextfile.csv") or die "cannot open\n";
      print $fh join("\n",@rows);
      $fh->close();
      @rows = ();
    }
    $nextfile = $tmp;
  } else {
    push @rows, $line;
  }
}

if (scalar @rows) {
  my $fh = IO::File->new();
  $fh->open(">data/$nextfile.csv") or die "cannot open\n";
  print $fh join("\n",@rows);
  $fh->close();
  @rows = ();
}
