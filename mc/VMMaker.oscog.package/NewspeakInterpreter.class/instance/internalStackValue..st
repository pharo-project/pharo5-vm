internal interpreter access
internalStackValue: offset

	^ self longAtPointer: localSP - (offset * BytesPerWord)