trampoline support
stackLimitAddress
	<api>
	<returnTypeC: #usqInt>
	^self cCode: '(usqInt)&GIV(stackLimit)'
		  inSmalltalk: [cogit simulatedVariableAddress: #stackLimitFromMachineCode in: self]