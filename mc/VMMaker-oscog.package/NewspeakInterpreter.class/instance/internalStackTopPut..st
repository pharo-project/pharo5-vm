internal interpreter access
internalStackTopPut: aValue

	^self longAtPointer: localSP put: aValue