trampoline support
primFailCodeAddress
	<api>
	<returnTypeC: #usqInt>
	^self cCode: [(self addressOf: primFailCode) asUnsignedInteger]
		inSmalltalk: [cogit simulatedReadWriteVariableAddress: #primFailCode in: self]