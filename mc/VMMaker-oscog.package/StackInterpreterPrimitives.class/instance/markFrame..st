object access primitives
markFrame: theFPInt
	stackPages
		longAt: theFPInt + FoxFrameFlags
		put: ((stackPages longAt: theFPInt + FoxFrameFlags) bitOr: 2)