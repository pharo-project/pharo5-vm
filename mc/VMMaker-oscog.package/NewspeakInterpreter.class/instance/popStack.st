internal interpreter access
popStack

	| top |
	top := self longAt: stackPointer.
	stackPointer := stackPointer - BytesPerWord.
	^ top