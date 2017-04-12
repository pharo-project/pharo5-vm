trampoline support
needGCFlagAddress
	<api>
	<returnTypeC: #usqInt>
	^self cCode: [(self addressOf: needGCFlag) asUnsignedInteger]
		inSmalltalk: [cogit simulatedReadWriteVariableAddress: #needGCFlag in: self]