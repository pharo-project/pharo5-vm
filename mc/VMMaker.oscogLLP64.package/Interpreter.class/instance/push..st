contexts
push: object

	| sp |
	self longAt: (sp := stackPointer + self wordSize) put: object.
	stackPointer := sp.