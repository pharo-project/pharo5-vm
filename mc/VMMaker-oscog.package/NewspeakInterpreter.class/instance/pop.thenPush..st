internal interpreter access
pop: nItems thenPush: oop

	| sp |
	self longAt: (sp := stackPointer - ((nItems - 1) * BytesPerWord)) put: oop.
	stackPointer := sp.
