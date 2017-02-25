trampoline support
primitiveFunctionPointerAddress
	<api>
	<returnTypeC: #usqInt>
	^self cCode: [(self addressOf: primitiveFunctionPointer) asUnsignedInteger]
		inSmalltalk: [cogit simulatedReadWriteVariableAddress: #primitiveFunctionPointer in: self]