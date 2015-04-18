debug printing
nameForOpcode: opcode "<Integer>"
	^opcode < LastRTLCode ifTrue:
		[(classPool keyAtValue: opcode ifAbsent: []) ifNotNil:
			[:opcodeName|
			((opcodeName beginsWith: 'First')
			 or: [opcodeName beginsWith: 'Last'])
				ifTrue: [#(JumpFull JumpLong JumpBelowOrEqual Jump) detect: [:k| (classPool at: k) = opcode]]
				ifFalse: [opcodeName]]]