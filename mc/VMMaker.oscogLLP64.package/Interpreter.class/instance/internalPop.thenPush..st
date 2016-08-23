contexts
internalPop: nItems thenPush: oop

	self longAtPointer: (localSP := localSP - ((nItems - 1) * self wordSize)) put: oop.
