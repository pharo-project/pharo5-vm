printing
symbolicOn: aStream
	| orneryOperands |
	<doNotGenerate> "Smalltalk-side only"
	(machineCodeSize isNil
	 or: [opcode = 16rAAA]) ifTrue:
		[^aStream nextPut: 'uninitialized opcode'].
	aStream space; nextPut: $(; nextPutAll: (self class nameForOpcode: opcode).
	orneryOperands := operands isCObjectAccessor
							ifTrue: [operands object]
							ifFalse: [operands].
	orneryOperands withIndexDo:
		[:operand :index|
		operand ifNotNil:
			[aStream space.
			 index >= (orneryOperands identityIndexOf: nil ifAbsent: [orneryOperands size + 1]) ifTrue:
				[aStream print: index - 1; nextPut: $:].
			 operand class == self class
				ifTrue:
					[operand symbolicOn: aStream]
				ifFalse:
					[aStream print: operand.
					 (operand isInteger and: [operand > 16]) ifTrue:
						[(operand allMask: 16r80000000) ifTrue:
							[aStream nextPut: $/; print: operand signedIntFromLong].
						 aStream nextPut: $/.
						 operand printOn: aStream base: 16]]]].
	machineCodeSize > 0 ifTrue:
		[machineCodeSize > machineCode size
			ifTrue: [aStream nextPutAll: ' no mcode']
			ifFalse:
				[0 to: machineCodeSize - 1 by: self codeGranularity do:
					[:i|
					 aStream space.
					 (self machineCodeAt: i) printOn: aStream base: 16]]].
	aStream nextPut: $)