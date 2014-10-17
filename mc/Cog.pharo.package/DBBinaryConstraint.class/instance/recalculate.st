planning
recalculate
	"Calculate the walkabout strength, the stay flag, and, if it is 'stay',
         the value for the current output of this constraint. Assume this
	 constraint is satisfied."

	| in out |
	direction == #forward
		ifTrue: [in := v1. out := v2]
		ifFalse: [in := v2. out := v1].
	out walkStrength: (strength weakest: in walkStrength).
	out stay: in stay.
	out stay ifTrue: [ self execute ].		"stay optimization"