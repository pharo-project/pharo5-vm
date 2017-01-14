bytecode generator support
genInlineClosure: startpc numArgs: numArgs numCopied: numCopied
	<inline: true>
	self assert: objectRepresentation getActiveContextAllocatesInMachineCode.
	 self voidReceiverResultRegContainsSelf.
	 self ssAllocateCallReg: ReceiverResultReg
		and: SendNumArgsReg
		and: ClassReg.
	 objectRepresentation
		genNoPopCreateClosureAt: startpc + 1 "1 relative"
		numArgs: numArgs
		numCopied: numCopied
		contextNumArgs: methodOrBlockNumArgs
		large: (coInterpreter methodNeedsLargeContext: methodObj)
		inBlock: inBlock.
	 1 to: numCopied do:
		[:i| | reg |
		 reg := self ssStorePop: true toPreferredReg: TempReg.
		 objectRepresentation
			genStoreSourceReg: reg
			slotIndex: ClosureFirstCopiedValueIndex + numCopied - i
			intoNewObjectInDestReg: ReceiverResultReg].
	 self ssPushRegister: ReceiverResultReg
