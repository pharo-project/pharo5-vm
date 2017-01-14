trampoline support
shadowCallStackAddress
	<option: #LowcodeVM>
	<api>
	<returnTypeC: #usqInt>
	^self cCode: [(self addressOf: shadowCallStackPointer) asUnsignedInteger]
		inSmalltalk: [cogit simulatedReadWriteVariableAddress: #shadowCallStackPointer in: self]