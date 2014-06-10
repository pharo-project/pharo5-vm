object access primitives
frameIsMarked: theFPInt
	| methodField |
	methodField := stackPages longAt: theFPInt + FoxMethod.
	^methodField asUnsignedInteger < objectMemory startOfMemory
		ifTrue: [(methodField bitAnd: 4) ~= 0]
		ifFalse: [((stackPages longAt: theFPInt + FoxIFrameFlags) bitAnd: 2) ~= 0]