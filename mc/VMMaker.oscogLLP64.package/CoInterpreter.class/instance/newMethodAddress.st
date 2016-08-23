trampoline support
newMethodAddress
	<api>
	<returnTypeC: #usqInt>
	^self cCode: [(self addressOf: newMethod) asUnsignedInteger]
		inSmalltalk: [cogit simulatedReadWriteVariableAddress: #newMethod in: self]