#!/usr/bin/perl -w
#

use strict;


my $passive_models
    = [
       'singlep',
#        'doublep',
#        'fork3p',
#        'fork4p1',
#        'fork4p2',
#        'fork4p3',
#        'triplep',
#        'tensizesp',
      ];

my $test
    = {
       command_definitions => [
			       map
			       {
				   my $model_name = $_;

				   (
				    {
				     arguments => [
						   "tests/scripts/$model_name.py",
						  ],
				     command => 'bin/gipyshell',
				     command_tests => [
						       {
							description => "Is startup successful ?",
							read => "tests/scripts/$model_name.py",
							timeout => 5,
						       },
						       {
							description => "Does the simulation complete?",
							read => "$model_name.py: simulation completed",
						       },
						       {
							description => "Can we quit the gipyshell?",
							write => "exit",
						       },
						       {
							comment => "Note that when this test does not wait for two second, it may fail",
							description => "Can we run the $model_name model ?",
							disabled => ($model_name eq 'tensizesp' ? 'the tensizesp model needs improvements of the numerical_compare heuristic' : 0),
							numerical_compare => 1,
							read => {
								 application_output_file => "/tmp/output",
								 expected_output_file => "$::config->{core_directory}/tests/specifications/strings/$model_name.txt",
								},
							wait => 2,
						       },
						      ],
				     description => "passive $model_name test",
				     side_effects => "creates the $model_name model in the model container",
				    },
				   );
			       }
			       @$passive_models,
			      ],
       description => "simulations of passive models (with current injection)",
       disabled => "this test only works from ipython 0.12 onwards.",
       name => 'passive.t',
      };


return $test;


