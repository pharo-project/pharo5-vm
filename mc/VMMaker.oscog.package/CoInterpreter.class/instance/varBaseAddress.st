cog jit support
varBaseAddress
	<api>
	<returnTypeC: #usqInt>
	^self cCode: [(self addressOf: stackPointer) asUnsignedInteger - 16r42]
		inSmalltalk: [cogit fakeVarBaseAddress]