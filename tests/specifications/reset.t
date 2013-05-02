#!/usr/bin/perl -w
#

use strict;


my $test
    = {
       command_definitions => [
			       {
				arguments => [
					      "tests/scripts/reset.py",
					     ],
				command => 'bin/gipyshell',
				command_tests => [
						  {
						   description => "Is startup successful ?",
						   read => "Welcome to the gipyshell",
						   timeout => 10,
						  },
						  {
						   description => "Does the simulation complete?",
						   read => "simulation completed",
						   wait => 2,
						  },
						  {
						   description => "Can we quit the gipyshell?",
						   wait => 2,
						   write => "exit()
",
						  },
						  {
						   comment => "Note that when this test does not wait for two second, it may fail",
						   description => "Do we find the output?",
						   numerical_compare => 1,
						   read => {
							    application_output_file => "/tmp/output",
							    expected_output_file => "$::config->{core_directory}/tests/specifications/strings/reset.txt",
							   },
						   wait => 2,
						  },
						 ],
				description => "reset test",
				side_effects => "creates a model in the model container",
			       },
			      ],
       description => "resetting the state of a model and simulation",
       name => 'reset.t',
      };


return $test;


