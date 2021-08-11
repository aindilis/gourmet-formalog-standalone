#!/usr/bin/env perl

use String::ShellQuote qw(shell_quote);

sub dirname {
  my ($path) = @_;
  $path =~ s|\/[^\/]+$||sg;
  return $path;
}

if (! $ENV{USER} eq 'root') {
  die "Run as a regular user\n";
}

die "gourmet-formalog already exists\n" if -d '/var/lib/myfrdcsa/codebases/minor/gourmet-formalog';

if (! -d '/var/lib/myfrdcsa/codebases/minor/gourmet-formalog') {
  print "CLONING Gourmet-Formalog\n";
  system 'cd /var/lib/myfrdcsa/codebases/minor/ && git clone https://github.com/aindilis/gourmet-formalog-standalone';
  system 'mv /var/lib/myfrdcsa/codebases/minor/gourmet-formalog-standalone /var/lib/myfrdcsa/codebases/minor/gourmet-formalog';
}

print "MAKING DIRECTORIES\n";
system 'mkdir -p /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/process';
system 'mkdir -p /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/recipes';

system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/process && swipl -g \"pack_install('julian',[interactive(false)]).\" -t halt";
system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/process && swipl -g \"pack_install('regex',[interactive(false)]).\" -t halt";
system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/process && swipl -g \"pack_install('expanded_string_utils-1.0.0.tgz',[interactive(false)]).\" -t halt";
system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/process && swipl -g \"pack_install('tsv_read_and_assert-1.0.0.tgz',[interactive(false)]).\" -t halt";


print "COPYING PROLOG DEPENDENCIES TO CORRECT LOCATIONS\n";
foreach my $file (split /\n/, `find /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/installer/redacted/var/lib/myfrdcsa/codebases/minor`) {
  if (-f $file) {
    print "<$file>\n";
    # create dirs and make links back to installer
    my $destinationfile = $file;
    if ($destinationfile =~ q|^/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/installer/redacted/|) {
      $destinationfile =~ s|^/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/installer/redacted||sg;
      if (! -f $destinationfile) {
	my $commands =
	  [
	   'mkdir -p '.shell_quote(dirname($destinationfile)),
	   'cd '.shell_quote(dirname($destinationfile)).' && ln -s '.shell_quote($file).' .',
	  ];
	foreach my $command (@$commands) {
	  print $command."\n";
	  system $command;
	}
      } else {
	die "Target file already exists: <$destinationfile>\n";
      }
    } else {
      die "Gourmet-formalog is not in the correct dir\n";
    }
  }
}

exit(0);

print "DOWNLOADING\n";
if (! -f '/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/process/FoodData_Central_csv_2019-12-17.zip') {
  print "DOWNLOADING FOODDATA CENTRAL CSV 2019-12-17\n";
  system 'cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/process && wget https://fdc.nal.usda.gov/fdc-datasets/FoodData_Central_csv_2019-12-17.zip';
}

if (! -f '/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/recipes/mm.pl') {
  print "DOWNLOADING MEALMASTER RECIPE ARCHIVE\n";
  system 'cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/recipes && wget https://frdcsa.org/~andrewdo/gourmet/mm.pl';
}

if (! -d '/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/wordnet/') {
  print "CLONING WNPROLOG-3.1\n";
  # actually get it from here if possible instead: https://github.com/ekaf/wordnet-prolog
  system 'cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts && git clone https://github.com/ekaf/wordnet-prolog';
  system 'mv /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/wordnet-prolog /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/wordnet';
  system 'cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/wordnet && ln -s wordnet/wnprolog.pl .';
  system 'cp /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/to-wordnet/* /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/wordnet';
}

if (! -f '/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/recipes/mm.qlf') {
  print "QCOMPILING mm.pl\n";
  system 'swipl -s /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/recipes/qcompile-mm.pl -g halt';
}
if (! -d "/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/process/USDA-Food-DB") {
  print "EXTRACTING FDC\n";
  system "mkdir -p /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/process/USDA-Food-DB";
  system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/process/USDA-Food-DB && unzip ../FoodData_Central_csv_2019-12-17.zip";
}
if (-d "/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/process/USDA-Food-DB") {
  print "QCOMPILING FDC\n";
  system "swipl -s /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/process/generate_fooddata.pl -g halt";
} else {
  die "no USDA-Food-DB directory\n";
}
if (! -d "/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/wordnet/prolog") {
  print "EXTRACTING Prolog WordNet\n";
  system "cd /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/wordnet/ && tar -xzf WNprolog-3.1.tar.gz";
}

if (! -d '/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/installer') {
  die "Gourmet-formalog is not in the correct dir, should be placed into /var/lib/myfrdcsa/codebases/minor/gourmet-formalog\n";
}
