trampoline support
instructionPointerAddress
	<api>
	<returnTypeC: #usqInt>
	^self cCode: [(self addressOf: instructionPointer) asUnsignedInteger]
		inSmalltalk: [cogit simulatedReadWriteVariableAddress: #instructionPointer in: self]