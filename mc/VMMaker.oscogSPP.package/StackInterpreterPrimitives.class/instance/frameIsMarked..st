object access primitives
frameIsMarked: theFPInt
	^((stackPages longAt: theFPInt + FoxFrameFlags) bitAnd: 2) ~= 0