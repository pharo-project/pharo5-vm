generate machine code - concretize
concretizeMoveCwR
	<var: #word type: #sqInt>
	| word reg |
	word := operands at: 0.
	reg := operands at: 1.
	self machineCodeAt: 0 put: (self luiR: reg C: (self high16BitsOf: word)).
	self machineCodeAt: 4 put: (self oriR: reg R: reg C: (self low16BitsOf: word)).
	^machineCodeSize := 8