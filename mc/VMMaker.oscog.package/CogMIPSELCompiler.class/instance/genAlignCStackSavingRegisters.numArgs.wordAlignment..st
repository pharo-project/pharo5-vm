abi
genAlignCStackSavingRegisters: saveRegs numArgs: numArgs wordAlignment: alignment 
	| wordsPushedModAlignment delta |
	self numIntRegArgs >= (saveRegs
								ifTrue: [self numberOfSaveableRegisters + numArgs]
								ifFalse: [numArgs])  ifTrue:
		[^0].
	wordsPushedModAlignment := ((saveRegs ifTrue: [self numberOfSaveableRegisters] ifFalse: [0])
									+ numArgs)
									\\ alignment.
	wordsPushedModAlignment ~= 0 ifTrue:
		[delta := alignment - wordsPushedModAlignment.
		 cogit SubCq: delta * 4 R: SPReg].
	^0