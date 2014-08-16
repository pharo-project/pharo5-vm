debug support
validInstructionPointer: theInstrPointer inMethod: aMethod framePointer: fp
	<var: #theInstrPointer type: #usqInt>
	<var: #aMethod type: #usqInt>
	<var: #fp type: #'char *'>
	| methodHeader |
	objectMemory hasSpurMemoryManagerAPI ifTrue:
		[methodHeader := self noAssertHeaderOf: aMethod. "-1 for pre-increment in fetchNextBytecode"
		 ^theInstrPointer >= (aMethod + (objectMemory lastPointerOf: aMethod) + BytesPerOop - 1)
		   and: [theInstrPointer < (aMethod + (objectMemory numBytesOf: aMethod) + BaseHeaderSize - 1)
		   and: ["If the method starts with a CallPrimitive opcode the instruction pointer should be past it."
			((self alternateHeaderHasPrimitiveFlag: methodHeader)
			 and: [theInstrPointer < (aMethod
									+ BytesPerOop - 1
									+ (objectMemory lastPointerOf: aMethod)
									+ (self sizeOfCallPrimitiveBytecode: methodHeader))])
				not]]].
	MULTIPLEBYTECODESETS ifTrue:
		[methodHeader := self noAssertHeaderOf: aMethod. "-1 for pre-increment in fetchNextBytecode"
		 ^theInstrPointer >= (aMethod + (objectMemory lastPointerOf: aMethod) + BytesPerOop - 1)
		   and: [theInstrPointer < (aMethod + (objectMemory numBytesOf: aMethod) + BaseHeaderSize - 1)
		   and: ["If the method starts with a CallPrimitive opcode the instruction pointer should be past it."
			((self headerIndicatesAlternateBytecodeSet: methodHeader)
			  and: [(self alternateHeaderHasPrimitiveFlag: methodHeader)
			  and: [theInstrPointer < (aMethod
									+ BytesPerOop - 1
									+ (objectMemory lastPointerOf: aMethod)
									+ (self sizeOfCallPrimitiveBytecode: methodHeader))]])
				not]]].
	"-1 for pre-increment in fetchNextBytecode"
	^theInstrPointer >= (aMethod + (objectMemory lastPointerOf: aMethod) + objectMemory bytesPerOop - 1)
	  and: [theInstrPointer < (aMethod + (objectMemory numBytesOf: aMethod) + objectMemory baseHeaderSize - 1)]