generate machine code - concretize
concretizeLogicalShiftLeftCqR
	| distance reg |
	distance := (operands at: 0) min: 31.
	reg := operands at: 1.
	self machineCodeAt: 0 put: (self sllR: reg R: reg C: distance).
	^machineCodeSize := 4