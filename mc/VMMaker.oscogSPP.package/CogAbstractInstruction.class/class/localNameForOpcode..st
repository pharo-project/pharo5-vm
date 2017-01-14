printing
localNameForOpcode: opcode
	^(self classPool keyAtValue: opcode ifAbsent: nil)
		ifNotNil: [:opcodeName| opcodeName]
		ifNil: [self == CogAbstractInstruction
				ifTrue: [opcode printString]
				ifFalse: [superclass localNameForOpcode: opcode]]