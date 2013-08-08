I/O primitives
primitiveKbdPeek

	self pop: 1.
	Sensor keyboardPressed
		ifTrue: [self pushInteger: Sensor primKbdPeek]
		ifFalse: [self push: objectMemory nilObject]