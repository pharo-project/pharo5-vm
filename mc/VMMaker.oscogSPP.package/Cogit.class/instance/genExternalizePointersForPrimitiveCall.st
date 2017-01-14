trampoline support
genExternalizePointersForPrimitiveCall
	self MoveR: FPReg Aw: coInterpreter framePointerAddress.
	backEnd hasLinkRegister
		ifTrue:
			["Set coInterpreter stackPointer to the topmost argument, skipping the return address."
			 self MoveR: SPReg Aw: coInterpreter stackPointerAddress.
			 self MoveR: LinkReg Aw: coInterpreter instructionPointerAddress]
		ifFalse:
			[self PopR: TempReg. "get retpc"
			 self MoveR: TempReg Aw: coInterpreter instructionPointerAddress.
			 "Set coInterpreter stackPointer to the topmost argument, skipping the return address."
			 self MoveR: SPReg Aw: coInterpreter stackPointerAddress].
	^0