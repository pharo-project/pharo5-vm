generating machine code
addressIsInInstructions: anAbstractOpcode 
	^opcodes notNil and: [(opcodes identityIndexOf: anAbstractOpcode ifAbsent: []) notNil]