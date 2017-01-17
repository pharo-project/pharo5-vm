generate machine code - concretize
concretizeNop
	self machineCodeAt: 0 put: self nop.
	^machineCodeSize := 4