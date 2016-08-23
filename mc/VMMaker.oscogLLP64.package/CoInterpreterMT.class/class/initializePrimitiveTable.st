initialization
initializePrimitiveTable
	super initializePrimitiveTable.
	COGMTVM ifTrue:
		[(227 to: 229) do:
			[:pidx| self assert: (PrimitiveTable at: pidx + 1) = #primitiveFail].
		PrimitiveTable
			at: 227 + 1 put: #primitiveVMCurrentThreadId;
			at: 228 + 1 put: #primitiveProcessBoundThreadId;
			at: 229 + 1 put: #primitiveProcessBindToThreadId]