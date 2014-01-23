debug support
validInstructionPointer: theInstrPointer inMethod: aMethod framePointer: fp
	<var: #theInstrPointer type: #usqInt>
	<var: #aMethod type: #usqInt>
	<var: #fp type: #'char *'>
	^self
		cppIf: MULTIPLEBYTECODESETS
		ifTrue:
			[| methodHeader |
			 methodHeader := self noAssertHeaderOf: aMethod. "-1 for pre-increment in fetchNextBytecode"
			 theInstrPointer >= (aMethod + (objectMemory lastPointerOf: aMethod) + BaseHeaderSize - 1)
			 and: [theInstrPointer < (aMethod + (objectMemory byteLengthOf: aMethod) + BaseHeaderSize - 1)
			 and: ["If the method starts with a CallPrimitive opcode the instruction pointer should be past it."
				((self headerIndicatesAlternateBytecodeSet: methodHeader)
				and: [(self alternateHeaderHasPrimitiveFlag: methodHeader)
				and: [theInstrPointer < (aMethod
										+ BaseHeaderSize - 1
										+ (objectMemory lastPointerOf: aMethod)
										+ (self sizeOfCallPrimitiveBytecode: methodHeader) - 1)]])
					not]]]
		ifFalse: "-1 for pre-increment in fetchNextBytecode"
			[theInstrPointer >= (aMethod + (objectMemory lastPointerOf: aMethod) + BaseHeaderSize - 1)
			 and: [theInstrPointer < (aMethod + (objectMemory byteLengthOf: aMethod) + BaseHeaderSize - 1)]]