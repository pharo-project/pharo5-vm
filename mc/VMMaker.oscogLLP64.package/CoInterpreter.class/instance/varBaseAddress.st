cog jit support
varBaseAddress
	<api>
	<returnTypeC: #usqInt>
	^self cCode: [(self addressOf: stackPointer) asUnsignedInteger - 16r40]
		inSmalltalk: [cogit fakeVarBaseAddress]