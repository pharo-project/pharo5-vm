generate machine code - concretize
concretizeStop
	self machineCodeAt: 0 put: self stop.
	^machineCodeSize := 4