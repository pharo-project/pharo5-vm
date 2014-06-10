bytecode generators
genUpArrowReturn
	"Generate a method return from within a method or a block.
	 Frameless method activation looks like
				receiver
				args
		sp->	ret pc.
	 Return pops receiver and arguments off the stack.  Callee pushes the result."
	self flag: 'currently caller pushes result'.
	inBlock ifTrue:
		[self assert: needsFrame.
		 self annotateBytecode: (self CallRT: ceNonLocalReturnTrampoline).
		 ^0].
	needsFrame ifTrue:
		[self MoveR: FPReg R: SPReg.
		 self PopR: FPReg].
	backEnd hasLinkRegister ifTrue:
		[self PopR: LinkReg].
	self RetN: methodOrBlockNumArgs + 1 * BytesPerWord.
	^0