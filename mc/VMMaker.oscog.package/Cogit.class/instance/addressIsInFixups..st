testing
addressIsInFixups: address
	<var: #address type: #'BytecodeFixup *'>
	^self cCode: '(AbstractInstruction *)address >= fixups && (AbstractInstruction *)address < (fixups + numAbstractOpcodes)'
		inSmalltalk:
			[fixups notNil
			 and: [(fixups object identityIndexOf: address) between: 1 and: numAbstractOpcodes]]