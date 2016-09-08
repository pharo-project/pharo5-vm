contexts
internalStackValue: offset

	^ self longAtPointer: localSP - (offset * self wordSize)