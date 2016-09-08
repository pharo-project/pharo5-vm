contexts
pop: nItems thenPush: oop

	| sp |
	self longAt: (sp := stackPointer - ((nItems - 1) * self wordSize)) put: oop.
	stackPointer := sp.
