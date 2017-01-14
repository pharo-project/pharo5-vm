trampoline support
nativeStackPointerAddress
	<option: #LowcodeVM>
	<api>
	<returnTypeC: #usqInt>
	^self cCode: [(self addressOf: nativeStackPointer) asUnsignedInteger]
		inSmalltalk: [cogit simulatedReadWriteVariableAddress: #nativeStackPointer in: self]