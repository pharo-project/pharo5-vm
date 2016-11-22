bytecode generator support
genMarshalledSend: selectorIndex numArgs: numArgs sendTable: sendTable
	self flushLiveRegistersForSend.
	^super genMarshalledSend: selectorIndex numArgs: numArgs sendTable: sendTable