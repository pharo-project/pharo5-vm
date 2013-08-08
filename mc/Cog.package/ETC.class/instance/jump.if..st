instruction decoding
jump: offset if: condition 
	"Conditional Jump bytecode."
	currentContext pop.
	offset > 0 ifTrue:
		[joinOffsets at: scanner pc + offset put: currentContext stackPtr]