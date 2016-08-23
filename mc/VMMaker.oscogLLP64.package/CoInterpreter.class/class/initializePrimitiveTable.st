initialization
initializePrimitiveTable
	super initializePrimitiveTable.
	#(216 253) do:
		[:pidx| self assert: (PrimitiveTable at: pidx + 1) = #primitiveFail].
	self assert: (PrimitiveTable at: 215 + 1) = #primitiveFlushCacheByMethod.
	PrimitiveTable
		at: 253 + 1 put: #primitiveCollectCogCodeConstituents;
		at: 215 + 1 put: #primitiveVoidVMStateForMethod;
		at: 216 + 1 put: #primitiveMethodXray