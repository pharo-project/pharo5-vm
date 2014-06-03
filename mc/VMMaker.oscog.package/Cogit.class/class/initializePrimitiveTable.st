class initialization
initializePrimitiveTable
	NewspeakVM
		ifTrue: [self initializePrimitiveTableForNewsqueak]
		ifFalse: [self initializePrimitiveTableForSqueak]