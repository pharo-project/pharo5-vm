trampoline support
specialObjectsArrayAddress
	<api>
	^self cCode: [(self addressOf: specialObjectsOop) asUnsignedInteger]
		inSmalltalk: [cogit simulatedVariableAddress: #specialObjectsOop in: self]