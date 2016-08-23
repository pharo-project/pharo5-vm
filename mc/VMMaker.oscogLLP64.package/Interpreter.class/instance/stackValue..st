contexts
stackValue: offset
	^ self longAt: stackPointer - (offset*self wordSize)