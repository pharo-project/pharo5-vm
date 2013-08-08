frame access
iframeInstructionPointerForIndex: ip method: aMethod
	"Answer the instruction pointer for use in an interpreter frame (a pointer to a bytecode)."
	self assert: (ip between: (objectMemory lastPointerOf: aMethod) and: (objectMemory lengthOf: aMethod)).
	^aMethod + ip + BaseHeaderSize - 2