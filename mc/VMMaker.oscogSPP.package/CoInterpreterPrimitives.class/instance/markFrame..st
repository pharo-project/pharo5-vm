object access primitives
markFrame: theFPInt
	| methodField |
	methodField := stackPages longAt: theFPInt + FoxMethod.
	methodField asUnsignedInteger < objectMemory startOfMemory
		ifTrue:
			[stackPages
				longAt: theFPInt + FoxMethod
				put: (methodField bitOr: 4)]
		ifFalse:
			[stackPages
				longAt: theFPInt + FoxIFrameFlags
				put: ((stackPages longAt: theFPInt + FoxIFrameFlags) bitOr: 2)]