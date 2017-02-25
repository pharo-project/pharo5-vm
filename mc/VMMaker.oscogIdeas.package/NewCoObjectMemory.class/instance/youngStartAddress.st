trampoline support
youngStartAddress
	<api>
	<returnTypeC: #usqInt>
	^self cCode: [(self addressOf: youngStart) asUnsignedInteger]
		inSmalltalk: [cogit simulatedReadWriteVariableAddress: #youngStart in: self]