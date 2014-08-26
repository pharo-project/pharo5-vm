stack access
stackTopPut: aValue

	^stackPages longAtPointer: stackPointer put: aValue