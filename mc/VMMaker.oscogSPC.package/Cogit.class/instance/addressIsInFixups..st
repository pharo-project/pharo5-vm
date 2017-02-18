testing
addressIsInFixups: address
	<var: #address type: #'BytecodeFixup *'>
	^self cCode: '(BytecodeFixup *)address >= fixups && (BytecodeFixup *)address < (fixups + numAbstractOpcodes)'
		inSmalltalk:
			[fixups notNil
			 and: [(fixups object identityIndexOf: address) between: 1 and: numAbstractOpcodes]]