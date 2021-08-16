#!/usr/bin/env perl

use File::Slurp qw(read_file);
use IO::File;

if (! -f '/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/fndds/data/2017-2018 FNDDS At A Glance - FNDDS Ingredients.xlsx') {
  system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/fndds/data && wget https://www.ars.usda.gov/ARSUserFiles/80400530/apps/2017-2018%20FNDDS%20At%20A%20Glance%20-%20Foods%20and%20Beverages.xlsx";
  system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/fndds/data && wget https://www.ars.usda.gov/ARSUserFiles/80400530/apps/2017-2018%20FNDDS%20At%20A%20Glance%20-%20Portions%20and%20Weights.xlsx";
  system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/fndds/data && wget https://www.ars.usda.gov/ARSUserFiles/80400530/apps/2017-2018%20FNDDS%20At%20A%20Glance%20-%20FNDDS%20Ingredients.xlsx";
  system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/fndds/data && wget https://www.ars.usda.gov/ARSUserFiles/80400530/apps/2017-2018%20FNDDS%20At%20A%20Glance%20-%20Ingredient%20Nutrient%20Values.xlsx";
  system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/fndds/data && wget https://www.ars.usda.gov/ARSUserFiles/80400530/apps/2017-2018%20FNDDS%20At%20A%20Glance%20-%20FNDDS%20Nutrient%20Values.xlsx";
}

if (! -f '/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/fndds/data/2017-2018 FNDDS At A Glance - FNDDS Ingredients.csv') {
  system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/fndds/data && xlsx2csv -a '2017-2018%20FNDDS%20At%20A%20Glance%20-%20Foods%20and%20Beverages.xlsx' > 2017-2018%20FNDDS%20At%20A%20Glance%20-%20Foods%20and%20Beverages.csv";
  system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/fndds/data && xlsx2csv -a '2017-2018%20FNDDS%20At%20A%20Glance%20-%20Portions%20and%20Weights.xlsx' > 2017-2018%20FNDDS%20At%20A%20Glance%20-%20Portions%20and%20Weights.csv";
  system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/fndds/data && xlsx2csv -a '2017-2018%20FNDDS%20At%20A%20Glance%20-%20FNDDS%20Ingredients.xlsx' > '2017-2018%20FNDDS%20At%20A%20Glance%20-%20FNDDS%20Ingredients.csv'";
  system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/fndds/data && xlsx2csv -a '2017-2018%20FNDDS%20At%20A%20Glance%20-%20Ingredient%20Nutrient%20Values.xlsx' > '2017-2018%20FNDDS%20At%20A%20Glance%20-%20Ingredient%20Nutrient%20Values.csv'";
  system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/fndds/data && xlsx2csv -a '2017-2018%20FNDDS%20At%20A%20Glance%20-%20FNDDS%20Nutrient%20Values.xlsx' > '2017-2018%20FNDDS%20At%20A%20Glance%20-%20FNDDS%20Nutrient%20Values.csv'";
}

# my $spreadsheets = [];
# my $nextfile;
# my @rows = ();

# my $c = read_file('OpenFoodToxTX22525_2020.csv');

# foreach my $line (split /\n/, $c) {
#   if ($line =~ /^-------- (\d+) - (.*?)$/) {
#     my $tmp = $2;
#     if (scalar @rows) {
#       my $fh = IO::File->new();
#       $fh->open(">data/$nextfile.csv") or die "cannot open\n";
#       print $fh join("\n",@rows);
#       $fh->close();
#       @rows = ();
#     }
#     $nextfile = $tmp;
#   } else {
#     push @rows, $line;
#   }
# }

# if (scalar @rows) {
#   my $fh = IO::File->new();
#   $fh->open(">data/$nextfile.csv") or die "cannot open\n";
#   print $fh join("\n",@rows);
#   $fh->close();
#   @rows = ();
# }
