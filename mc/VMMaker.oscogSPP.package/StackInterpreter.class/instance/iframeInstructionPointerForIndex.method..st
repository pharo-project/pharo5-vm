frame access
iframeInstructionPointerForIndex: ip method: aMethod
	"Answer the instruction pointer for use in an interpreter frame (a pointer to a bytecode)."
	self assert: (ip between: (((LiteralStart + (objectMemory literalCountOf: aMethod)) * objectMemory bytesPerOop)) + 1
					and: (objectMemory lengthOf: aMethod)).
	^aMethod + ip + objectMemory baseHeaderSize - 2