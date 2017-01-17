contexts
popStack

	| top |
	top := self longAt: stackPointer.
	stackPointer := stackPointer - self wordSize.
	^ top