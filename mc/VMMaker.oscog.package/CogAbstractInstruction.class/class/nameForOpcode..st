debug printing
nameForOpcode: opcode "<Integer>"
	^(CogRTLOpcodes nameForOpcode: opcode)
		ifNotNil:
			[:opcodeName| opcodeName]
		ifNil:
			[self localNameForOpcode: opcode]