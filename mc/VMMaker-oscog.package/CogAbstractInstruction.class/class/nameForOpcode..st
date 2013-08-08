debug printing
nameForOpcode: opcode "<Integer>"
	^(CogRTLOpcodes nameForOpcode: opcode)
		ifNotNil:
			[:opcodeName| opcodeName]
		ifNil:
			[(self classPool keyAtValue: opcode ifAbsent: [])
				ifNotNil: [:opcodeName| opcodeName]
				ifNil: [opcode printString]]