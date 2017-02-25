trampoline support
framePointerAddress
	<api>
	<returnTypeC: #usqInt>
	^self cCode: [(self addressOf: framePointer) asUnsignedInteger]
		inSmalltalk: [cogit simulatedReadWriteVariableAddress: #framePointer in: self]