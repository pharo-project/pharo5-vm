trampoline support
genExternalizePointersForPrimitiveCall
	backEnd hasLinkRegister
		ifTrue: [self PushR: LinkReg]
		ifFalse: [self MoveMw: 0 r: SPReg R: ClassReg].
	self MoveR: FPReg Aw: coInterpreter framePointerAddress.
	"Set coInterpreter stackPointer to the topmost argument, skipping the return address."
	self LoadEffectiveAddressMw: BytesPerWord r: SPReg R: TempReg.
	backEnd hasLinkRegister
		ifTrue: [self MoveR: LinkReg Aw: coInterpreter instructionPointerAddress]
		ifFalse: [self MoveR: ClassReg Aw: coInterpreter instructionPointerAddress].
	self MoveR: TempReg Aw: coInterpreter stackPointerAddress.
	^0