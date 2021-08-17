#!/usr/bin/env perl

use File::Slurp qw(read_file);
use IO::File;

if (! -d '/var/lib/myfrdcsa/codebases/minor-data/gourmet-formalog/source/toxicity/') {
  system "mkdir -p '/var/lib/myfrdcsa/codebases/minor-data/gourmet-formalog/source/toxicity/'";
}

if (! -f '/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/data/source/toxicity/OpenFoodToxTX22525_2020.xlsx') {
  system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/data/source/toxicity && wget https://zenodo.org/record/3693783/files/OpenFoodToxTX22525_2020.xlsx?download=1";
  system "mv '/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/data/source/toxicity/OpenFoodToxTX22525_2020.xlsx?download=1' '/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/data/source/toxicity/OpenFoodToxTX22525_2020.xlsx'";
}
if (! -f '/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/data/source/toxicity/OpenFoodToxTX22525_2020.csv') {
  system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/data/source/toxicity && xlsx2csv -a 'OpenFoodToxTX22525_2020.xlsx' > OpenFoodToxTX22525_2020.csv";
}

my $spreadsheets = [];
my $nextfile;
my @rows = ();

my $c = read_file('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/data/source/toxicity/OpenFoodToxTX22525_2020.csv');

foreach my $line (split /\n/, $c) {
  if ($line =~ /^-------- (\d+) - (.*?)$/) {
    my $tmp = $2;
    if (scalar @rows) {
      my $fh = IO::File->new();
      $fh->open(">/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/data/source/toxicity/$nextfile.csv") or die "cannot open\n";
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
  $fh->open(">/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/data/source/toxicity/$nextfile.csv") or die "cannot open\n";
  print $fh join("\n",@rows);
  $fh->close();
  @rows = ();
}

system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/toxicity/ && swipl -s ./generate_toxicity.pl";
