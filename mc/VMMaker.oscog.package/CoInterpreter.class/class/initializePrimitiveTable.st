initialization
initializePrimitiveTable
	super initializePrimitiveTable.
	self assert: (PrimitiveTable at: 253 + 1) = #primitiveFail.
	PrimitiveTable at: 253 + 1 put: #primitiveCollectCogCodeConstituents.
	self assert: (PrimitiveTable at: 215 + 1) = #primitiveFlushCacheByMethod.
	PrimitiveTable at: 215 + 1 put: #primitiveVoidVMStateForMethod