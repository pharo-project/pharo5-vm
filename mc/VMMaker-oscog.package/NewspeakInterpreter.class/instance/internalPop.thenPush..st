internal interpreter access
internalPop: nItems thenPush: oop

	self longAtPointer: (localSP := localSP - ((nItems - 1) * BytesPerWord)) put: oop.
