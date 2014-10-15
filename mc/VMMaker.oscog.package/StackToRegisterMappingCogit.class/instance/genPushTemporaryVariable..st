bytecode generators
genPushTemporaryVariable: index
	"If a frameless method (not a block), only argument temps can be accessed.
	 This is assured by the use of needsFrameIfMod16GENumArgs: in pushTemp."
	self assert: (inBlock or: [needsFrame or: [index < methodOrBlockNumArgs]]).
	^self ssPushDesc: (simStack at: index)