internal interpreter access
stackValue: offset put: oop
	^self longAt: stackPointer - (offset*self wordSize)
		put: oop