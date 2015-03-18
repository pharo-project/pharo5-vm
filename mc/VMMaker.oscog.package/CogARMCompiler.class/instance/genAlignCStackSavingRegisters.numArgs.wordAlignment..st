abi
genAlignCStackSavingRegisters: saveRegs numArgs: numArgs wordAlignment: alignment 
"ARM doesn't push the first 4 arguments. Now, currently Cog doesn't use more than 4 args so we should never need to push any - but just in case we'll check for it"
	| wordsPushedModAlignment delta |
	wordsPushedModAlignment := ((saveRegs ifTrue: [self numberOfSaveableRegisters] ifFalse: [0])
									+ (numArgs > 4 ifTrue:[numArgs - 4] ifFalse:[0]))
									\\ alignment.
	wordsPushedModAlignment ~= 0 ifTrue:
		[delta := alignment - wordsPushedModAlignment.
		 cogit SubCq: delta * 4 R: SPReg].
	^0