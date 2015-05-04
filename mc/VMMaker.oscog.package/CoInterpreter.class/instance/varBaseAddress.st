cog jit support
varBaseAddress
	<api>
	<returnTypeC: #usqInt>
	^(self addressOf: stackPointer) asUnsignedInteger - 16r42