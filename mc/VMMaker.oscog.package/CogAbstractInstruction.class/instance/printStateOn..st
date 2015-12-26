printing
printStateOn: aStream
	| opcodeName orneryOperands format |
	<doNotGenerate> "Smalltalk-side only"
	opcode ifNil:
		[^self].
	aStream space; nextPut: $(; nextPutAll: (opcodeName := self class nameForOpcode: opcode).
	orneryOperands := operands isCObjectAccessor
							ifTrue: [operands object]
							ifFalse: [operands].
	format := ((CogRTLOpcodes classPool includesKey: opcodeName)
				ifTrue: [CogRTLOpcodes]
				ifFalse: [self class]) printFormatForOpcodeName: opcodeName.
	orneryOperands withIndexDo:
		[:operand :index|
		operand ifNotNil:
			[aStream space.
			 index >= (orneryOperands identityIndexOf: nil ifAbsent: [orneryOperands size + 1]) ifTrue:
				[aStream print: index - 1; nextPut: $:].
			 (format notNil and: ['rf' includes: (format at: index ifAbsent: $-)])
				ifTrue: [aStream nextPutAll: ((format at: index) = $r
												ifTrue: [self nameForRegister: operand]
												ifFalse: [self nameForFPRegister: operand])]
				ifFalse:
					[aStream print: operand.
					 (operand isInteger and: [operand > 16 and: [opcode ~= Label]]) ifTrue:
						[(operand allMask: 16r80000000) ifTrue:
							[aStream nextPut: $/; print: operand signedIntFromLong].
						 aStream nextPut: $/.
						 operand printOn: aStream base: 16]]]].
	machineCodeSize ifNotNil:
		[(machineCodeSize between: 1 and: machineCode size) ifTrue:
			[0 to: machineCodeSize - 1 by: self codeGranularity do:
				[:i|
				 aStream space.
				 (self machineCodeAt: i)
					ifNil: [aStream nextPut: $.]
					ifNotNil:
						[:mc|
						mc isInteger
							ifTrue: [mc printOn: aStream base: 16]
							ifFalse: [mc printOn: aStream]]]]].
	address ifNotNil:
		[aStream nextPut: $@.
		 address printOn: aStream base: 16].
	aStream nextPut: $)