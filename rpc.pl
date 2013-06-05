#!/usr/bin/perl -w

use strict;
use JSON::RPC::Client;
use Data::Dump;

my $client = new JSON::RPC::Client;
my $port = 80;

my $url = "http://openqa.tanana.suse.de:$port/jsonrpc";

my %cmds = map { $_ => 0 } (qw/
	list_jobs
	list_workers
	list_commands
	/);
for (qw/
	echo
	job_delete
	job_release
	job_stop
	job_waiting
	job_continue
	job_find_by_name
	job_restart_by_name
	iso_new
	command_get
	/) {
	$cmds{$_} = 1;
}
for (qw/
	job_set_prio
	job_grab
	job_done
	job_update_result
	command_enqueue
	command_dequeue
	/) {
	$cmds{$_} = 2;
}
$cmds{worker_register} = 3;
$cmds{job_create} = 99;

$client->prepare($url, [keys %cmds]) or die "$!\n";
while (my $cmd = shift @ARGV) {
	unless (exists $cmds{$cmd}) {
		warn "invalid command $cmd";
		next;
	}
	my @args;
	@args = splice(@ARGV,0,$cmds{$cmd}) if $cmds{$cmd};
	printf "calling %s(%s)\n", $cmd, join(', ', @args);
	my $ret;
	eval qq{
		\$ret = \$client->$cmd(\@args);
	};
	die ">>> $@ <<<\n" if ($@);
	dd $ret;
}

1;
