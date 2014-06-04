internal interpreter access
internalStackTopPut: aValue

	^stackPages longAtPointer: localSP put: aValue