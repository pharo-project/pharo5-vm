contexts
stackValue: offset
	^ self longAt: stackPointer - (offset*BytesPerWord)