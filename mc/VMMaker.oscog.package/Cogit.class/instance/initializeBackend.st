initialization
initializeBackend
	methodLabel machineCodeSize: 0.
	methodLabel opcode: Label.
	methodLabel operands at: 0 put: 0.
	methodLabel operands at: 1 put: 0. "label offset"
	backEnd hasVarBaseRegister ifTrue:
		[self assert: ((self registerMaskFor: VarBaseReg) noMask: CallerSavedRegisterMask)].
	literalsManager allocateLiterals: 4; resetLiterals