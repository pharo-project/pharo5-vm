planning
recalculate
	"Calculate the walkabout strength, the stay flag, and, if it is 'stay',
	 the value for the current output of this constraint. Assume this
	 constraint is satisfied."

	output walkStrength: strength.
	output stay: self isInput not.
	output stay ifTrue: [self execute].	"stay optimization"