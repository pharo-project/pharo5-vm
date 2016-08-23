testing
addressIsInInstructions: address
	<var: #address type: #'AbstractInstruction *'>
	^self cCode: '!((usqInt)(address) & BytesPerWord-1) \
				&& (address) >= &abstractOpcodes[0] \
				&& (address) < &abstractOpcodes[opcodeIndex]'
		inSmalltalk: [(abstractOpcodes object identityIndexOf: address) between: 1 and: opcodeIndex]