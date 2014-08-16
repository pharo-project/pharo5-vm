debug support
context: aContext hasValidInversePCMappingOf: theIP in: theFP
	"For asserts.  Check that theIP maps back correctly to the context's pc.
	 The CallPrimitive bytecode presents a complication."
	| pc encodedip |
	<var: #theFP type: #'char *'>
	pc := objectMemory fetchPointer: InstructionPointerIndex ofObject: aContext.
	encodedip := self contextInstructionPointer: theIP frame: theFP.
	^(objectMemory hasSpurMemoryManagerAPI or: [MULTIPLEBYTECODESETS])
		ifTrue:
			[pc = encodedip
			or: [| methodHeader |
				methodHeader := objectMemory methodHeaderOf: (objectMemory fetchPointer: MethodIndex ofObject: aContext).
				(self methodHeaderHasPrimitive: methodHeader)
				and: [(objectMemory integerValueOf: encodedip) - (objectMemory integerValueOf: pc)
					= (self sizeOfCallPrimitiveBytecode: methodHeader)]]]
		ifFalse: [pc = encodedip]