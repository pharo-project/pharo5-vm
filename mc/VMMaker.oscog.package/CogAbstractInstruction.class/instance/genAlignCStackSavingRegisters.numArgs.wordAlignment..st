abi
genAlignCStackSavingRegisters: registerMask numArgs: numArgs wordAlignment: alignment
	<inline: true>
	| regMaskCopy numRegsPushed wordsPushedModAlignment delta |
	<var: 'regMaskCopy' type: #usqInt>
	regMaskCopy := registerMask asUnsignedInteger.
	numRegsPushed := 0.
	[regMaskCopy ~= 0] whileTrue:
		[numRegsPushed := numRegsPushed + (regMaskCopy bitAnd: 1).
		 regMaskCopy := regMaskCopy bitShift: -1].
	(numRegsPushed = 0
	 and: [self numIntRegArgs >= numArgs]) ifTrue:
		[^0].
	wordsPushedModAlignment := numRegsPushed + numArgs \\ alignment.
	wordsPushedModAlignment ~= 0 ifTrue:
		[delta := alignment - wordsPushedModAlignment.
		 cogit SubCq: delta * objectMemory wordSize R: SPReg].
	^0