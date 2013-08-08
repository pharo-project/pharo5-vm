trampoline support
argumentCountAddress
	<api>
	<returnTypeC: #usqInt>
	^self cCode: [(self addressOf: argumentCount) asUnsignedInteger]
		inSmalltalk: [cogit simulatedReadWriteVariableAddress: #argumentCount in: self]