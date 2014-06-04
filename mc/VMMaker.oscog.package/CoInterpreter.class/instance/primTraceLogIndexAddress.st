cog jit support
primTraceLogIndexAddress
	<api>
	<returnTypeC: #usqInt>
	"N.B. primTraceLogIndex is 8-bits"
	^self cCode: [(self addressOf: primTraceLogIndex) asUnsignedInteger]
		inSmalltalk: [cogit simulatedReadWriteVariableAddress: #primTraceLogIndex in: self]