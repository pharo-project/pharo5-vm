testing
addressIsInInstructions: address
	<var: #address type: #'AbstractInstruction *'>
	^self cCode:
			'address >= &abstractOpcodes[0] && address < &abstractOpcodes[opcodeIndex]
			|| address >= &counters[0] && address < &counters[counterIndex]'
		inSmalltalk:
			[((abstractOpcodes object identityIndexOf: address) between: 1 and: opcodeIndex)
			or: [(counters object identityIndexOf: address) between: 1 and: counterIndex]]