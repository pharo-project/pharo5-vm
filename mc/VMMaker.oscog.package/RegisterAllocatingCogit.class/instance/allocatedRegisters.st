simulation stack
allocatedRegisters
	| regsSet |
	self assert: needsFrame.
	regsSet := 0.
	0 to: methodOrBlockNumTemps do:
		[:i|
		regsSet := regsSet bitOr: (self simStackAt: i) registerMask].
	^regsSet