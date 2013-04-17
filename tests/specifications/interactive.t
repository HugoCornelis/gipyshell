#!/usr/bin/perl -w
#

use strict;


my $test
    = {
       command_definitions => [
			       {
				arguments => [
					     ],
				command => 'bin/gipyshell',
				command_tests => [
						  {
						   description => "Is startup successful ?",
						   read => "In ",
						   timeout => 5,
						  },
						  {
						   description => "models.Load('tests/cells/singlep.ndf')",
						   wait => 1,
						   write => "models.Load('tests/cells/singlep.ndf')",
						  },
						  {
						   description => "i = g3.CreateInput('perfect clamp', 'perfectclamp', verbose=True)",
						   wait => 1,
						   write => "i = g3.CreateInput('perfect clamp', 'perfectclamp', verbose=True)",
						  },
						  {
						   description => "i.AddInput('/singlep/segments/soma', 'INJECT')",
						   wait => 1,
						   write => "i.AddInput('/singlep/segments/soma', 'INJECT')",
						  },
						  {
						   description => "i.SetCommandVoltage(1e-9)",
						   wait => 1,
						   write => "i.SetCommandVoltage(1e-9)",
						  },
						  {
						   description => "o = g3.CreateOutput('output', 'double_2_ascii')",
						   wait => 1,
						   write => "o = g3.CreateOutput('output', 'double_2_ascii')",
						  },
						  {
						   description => "o.SetFilename('/tmp/output')",
						   wait => 1,
						   write => "o.SetFilename('/tmp/output')",
						  },
						  {
						   description => "o.AddOutput('/singlep/segments/soma', 'Vm')",
						   wait => 1,
						   write => "o.AddOutput('/singlep/segments/soma', 'Vm')",
						  },
						  {
						   description => "h = g3.CreateSolver('solver', 'heccer', verbose=True)",
						   wait => 1,
						   write => "h = g3.CreateSolver('solver', 'heccer', verbose=True)",
						  },
						  {
						   description => "h.SetModelName('/singlep')",
						   wait => 1,
						   write => "h.SetModelName('/singlep')",
						  },
						  {
						   description => "h.SetTimeStep(1e-05)",
						   wait => 1,
						   write => "h.SetTimeStep(1e-05)",
						  },
						  {
						   description => "g3.Run(steps=100)",
						   wait => 1,
						   write => "g3.Run(steps=100)",
						  },
						  {
						   description => "print \"simulation completed\"",
						   wait => 1,
						   write => "print \"simulation completed\"",
						  },
						  {
						   description => "Can we quit the gipyshell?",
						   wait => 1,
						   write => "exit",
						  },
						  {
						   comment => "Note that when this test does not wait for two second, it may fail",
						   description => "Can we run the model ?",
# 						   disabled => ($model_name eq 'tensizesp' ? 'the tensizesp model needs improvements of the numerical_compare heuristic' : 0),
						   numerical_compare => 1,
						   read => {
							    application_output_file => "/tmp/output",
							    expected_output_file => "$::config->{core_directory}/tests/specifications/strings/singlep.txt",
							   },
						   wait => 2,
						  },
						 ],
				description => "interactive test",
				side_effects => "creates a model in the model container",
			       },
			      ],
       description => "interactive simulation of passive models (with current injection)",
#        disabled => "interactive regression tests seem not to work with ipython 0.11 and earlier",
       name => 'interactive.t',
      };


return $test;


