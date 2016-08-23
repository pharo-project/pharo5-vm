initialization
generateVMOwnerLockFunctions
	| startAddress |
	<inline: true>
	self cppIf: COGMTVM
		ifTrue:
			[self allocateOpcodes: backEnd numLowLevelLockOpcodes bytecodes: 0.
			self zeroOpcodeIndex.
			startAddress := methodZoneBase.
			backEnd generateLowLevelTryLock: coInterpreter vmOwnerLockAddress.
			self outputInstructionsForGeneratedRuntimeAt: startAddress.
			self recordGeneratedRunTime: 'ceTryLockVMOwner' address: startAddress.
			ceTryLockVMOwner := self cCoerceSimple: startAddress to: #'usqIntptr_t (*)(void)'.

			self zeroOpcodeIndex.
			initialPC := 0.
			endPC := numAbstractOpcodes - 1.
			startAddress := methodZoneBase.
			backEnd generateLowLevelUnlock: coInterpreter vmOwnerLockAddress.
			self outputInstructionsForGeneratedRuntimeAt: startAddress.
			self recordGeneratedRunTime: 'ceUnlockVMOwner' address: startAddress.
			ceUnlockVMOwner := self cCoerceSimple: startAddress to: #'void (*)(void)']