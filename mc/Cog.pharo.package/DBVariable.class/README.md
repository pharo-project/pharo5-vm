I represent a constrained variable. In addition to my value, I maintain the structure of the constraint graph, the current dataflow graph, and various parameters of interest to the DeltaBlue incremental constraint solver.

Instance variables:
	value			my value; changed by constraints, read by client <Object>
	constraints		normal constraints that reference me <Array of Constraint>
	determinedBy	the constraint that currently determines
					my value (or nil if there isn''t one) <Constraint>
	walkStrength		my walkabout strength <Strength>
	stay			true if I am a planning-time constant <Boolean>
	mark			used by the planner to mark constraints <Number>