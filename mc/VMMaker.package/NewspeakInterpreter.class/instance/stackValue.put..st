internal interpreter access
stackValue: offset put: oop
	^self longAt: stackPointer - (offset*BytesPerWord)
		put: oop