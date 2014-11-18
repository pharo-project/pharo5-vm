bytecode generators
genBlockReturn
	"Return from block, assuming result already loaded into ReceiverResultReg."
	needsFrame ifTrue:
		[self MoveR: FPReg R: SPReg.
		 self PopR: FPReg].
	"Tim, I disagree; link reg should only be popped if frameful.
	 Frameless methods should /not/ push the link reg except around trampolines.
	 Eliot"
	backEnd hasLinkRegister ifTrue:
		[self PopR: LinkReg].
	self RetN: methodOrBlockNumArgs + 1 * objectMemory wordSize.
	^0