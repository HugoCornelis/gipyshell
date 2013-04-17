#! /usr/bin/env gipyshell
"""
A script that injects a current into a model with a single passive compartment.
"""

##########
# user work-flow step 1: create model

models.Load('tests/cells/singlep.ndf')

##########
# user work-flow step 2: create experiment, (a) input

i = g3.CreateInput('perfect clamp', 'perfectclamp', verbose=True)

i.AddInput('/singlep/segments/soma', 'INJECT')

i.SetCommandVoltage(1e-9)

##########
# user work-flow step 2: create experiment, (b) output

o = g3.CreateOutput('output', 'double_2_ascii')

o.SetFilename('/tmp/output')

o.AddOutput('/singlep/segments/soma', 'Vm')

##########
# user work-flow step 3: run simulation, see also above

h = g3.CreateSolver('solver', 'heccer', verbose=True)

h.SetModelName('/singlep')

h.SetTimeStep(1e-05)

g3.Run(steps=100)

# g3.Reset()

# g3.Run(steps=10, finish=True)

##########
# user work-flow step 4: collect output

print "*** simulation completed"


