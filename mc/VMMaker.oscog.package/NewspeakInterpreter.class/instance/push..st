internal interpreter access
push: object

	| sp |
	self longAt: (sp := stackPointer + BytesPerWord) put: object.
	stackPointer := sp.