generate machine code - concretize
concretizePrefetchAw
	| addressOperand |
	addressOperand := operands at: 0.
	self machineCodeAt: 0 put: (self luiR: AT C: (self high16BitsOf: addressOperand)).
	self machineCodeAt: 4 put: (self oriR: AT R: AT C: (self low16BitsOf: addressOperand)).
	self machineCodeAt: 8 put: (self prefR: AT offset: 0 hint: HintLoad).
	^machineCodeSize := 12