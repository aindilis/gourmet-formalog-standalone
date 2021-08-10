#!/usr/bin/env perl

die "DONT USE\n";

use PerlLib::SwissArmyKnife;
use MyFRDCSA qw(ConcatDir);

my $gourmetdir = '/var/lib/myfrdcsa/collaborative/git/gourmet-formalog/installer';
my $c = read_file('/var/lib/myfrdcsa/collaborative/git/gourmet-formalog/installer/files-all.txt');
foreach my $file (split /\n/, $c) {
  print "<$file>\n";
  my $targetfile = "to-redact$file";
  my $redactedfile = "redacted$file";
  if (! -f ConcatDir($gourmetdir,$redactedfile) and
      $file !~ q|/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/|) {
    my $dirname = dirname($targetfile);
    my $commands =
      [
       'mkdir -p '.shell_quote(ConcatDir($gourmetdir,$dirname)),
       'cp -ar '.shell_quote($file).' '.shell_quote(ConcatDir($gourmetdir,$targetfile)),
      ];
    print Dumper($commands);
    ApproveCommands
      (
       Commands => $commands,
       Method => 'sequential',
       AutoApprove => 1,
      );
  }
}

