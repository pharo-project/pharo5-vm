contexts
internalStackValue: offset

	^ self longAtPointer: localSP - (offset * BytesPerWord)