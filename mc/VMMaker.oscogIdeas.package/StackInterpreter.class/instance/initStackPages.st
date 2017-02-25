initialization
initStackPages
	"Initialize the stackPages.  This version is only for simulation
	 because Slang refuses to inline it, which makes the alloca invalid."
	| stackPageBytes stackPagesBytes theStackMemory |
	stackPageBytes := self stackPageByteSize.
	stackPagesBytes := self computeStackZoneSize.
	theStackMemory := self
							cCode: [self alloca: stackPagesBytes]
							inSmalltalk: [stackPages initializeWithByteSize: stackPagesBytes for: self].
	self cCode: [self me: theStackMemory ms: 0 et: stackPagesBytes].
	stackPages
		initializeStack: theStackMemory
		numSlots: stackPagesBytes / objectMemory wordSize
		pageSize: stackPageBytes / objectMemory wordSize