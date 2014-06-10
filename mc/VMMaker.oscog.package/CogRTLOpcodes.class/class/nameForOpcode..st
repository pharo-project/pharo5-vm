debug printing
nameForOpcode: opcode "<Integer>"
	^(classPool keyAtValue: opcode ifAbsent: []) ifNotNil:
		[:opcodeName|
		((opcodeName beginsWith: 'First')
		 or: [opcodeName beginsWith: 'Last'])
			ifTrue: [#(JumpLong JumpBelowOrEqual Jump) detect: [:k| (classPool at: k) = opcode]]
			ifFalse: [opcodeName]]