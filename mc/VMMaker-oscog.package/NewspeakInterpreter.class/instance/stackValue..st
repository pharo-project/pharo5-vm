internal interpreter access
stackValue: offset
	^ self longAt: stackPointer - (offset*BytesPerWord)