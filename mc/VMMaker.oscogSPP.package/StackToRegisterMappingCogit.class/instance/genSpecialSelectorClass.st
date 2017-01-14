bytecode generators
genSpecialSelectorClass
	| topReg |
	topReg := self ssTop registerOrNone.
	self ssPop: 1.
	(topReg = NoReg or: [topReg = ClassReg])
		ifTrue: [self ssAllocateRequiredReg: (topReg := SendNumArgsReg) and: ClassReg]
		ifFalse: [self ssAllocateRequiredReg: ClassReg].
	self ssPush: 1.
	self ssTop popToReg: topReg.
	objectRepresentation
		genGetClassObjectOf: topReg
		into: ClassReg
		scratchReg: TempReg
		instRegIsReceiver: false.
	^self ssPop: 1; ssPushRegister: ClassReg