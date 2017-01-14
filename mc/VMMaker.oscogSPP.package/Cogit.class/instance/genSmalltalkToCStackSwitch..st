trampoline support
genSmalltalkToCStackSwitch: pushLinkReg
	"If the client requires, then on an ARM-like RISC processor, the return address needs to
	 be pushed to the stack so that the interpreter sees the same stack layout as on CISC."
	(backEnd hasLinkRegister and: [pushLinkReg]) ifTrue:
		[self PushR: LinkReg].
	backEnd genSaveStackPointers.
	cFramePointerInUse
		ifTrue: [backEnd genLoadCStackPointers]
		ifFalse: [backEnd genLoadCStackPointer].
	^0