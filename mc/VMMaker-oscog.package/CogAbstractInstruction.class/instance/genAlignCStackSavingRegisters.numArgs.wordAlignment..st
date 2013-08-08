abi
genAlignCStackSavingRegisters: saveRegs numArgs: numArgs wordAlignment: alignment 
	| wordsPushedModAlignment delta |
	wordsPushedModAlignment := ((saveRegs ifTrue: [self numberOfSaveableRegisters] ifFalse: [0])
									+ numArgs)
									\\ alignment.
	wordsPushedModAlignment ~= 0 ifTrue:
		[delta := alignment - wordsPushedModAlignment.
		 cogit SubCq: delta * 4 R: SPReg].
	^0