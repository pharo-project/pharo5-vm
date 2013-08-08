I/O primitives
primitiveMouseButtons
	| buttons |
	self pop: 1.
	buttons := Sensor primMouseButtons.
	self pushInteger: buttons