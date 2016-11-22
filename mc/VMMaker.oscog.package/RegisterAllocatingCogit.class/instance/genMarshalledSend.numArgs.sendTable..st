bytecode generator support
genMarshalledSend: selectorIndex numArgs: numArgs sendTable: sendTable
	self flushLiveRegistersForSend: numArgs.
	^super genMarshalledSend: selectorIndex numArgs: numArgs sendTable: sendTable