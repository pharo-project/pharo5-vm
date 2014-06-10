testing
addressIsInFixups: address
	<var: #address type: #'AbstractInstruction *'>
	^self cCode: 'address >= (AbstractInstruction *)&fixups[0] && address < (AbstractInstruction *)&fixups[numAbstractOpcodes]'
		inSmalltalk: [fixups notNil
					and: [(fixups object identityIndexOf: address) between: 1 and: numAbstractOpcodes]]