private
abstractRegisterForConcreteRegister: reg
	(self concreteRegister: TempReg) = reg ifTrue: [^TempReg].
	(self concreteRegister: ReceiverResultReg) = reg ifTrue: [^ReceiverResultReg].
	(self concreteRegister: ClassReg) = reg ifTrue: [^ClassReg].
	(self concreteRegister: SendNumArgsReg) = reg ifTrue: [^SendNumArgsReg].
	(self concreteRegister: Arg0Reg) = reg ifTrue: [^Arg0Reg].
	(self concreteRegister: Arg1Reg) = reg ifTrue: [^Arg1Reg].
	(self concreteRegister: FPReg) = reg ifTrue: [^FPReg].
	(self concreteRegister: SPReg) = reg ifTrue: [^SPReg].
	(self concreteRegister: LinkReg) = reg ifTrue: [^LinkReg].
	(self concreteRegister: RISCTempReg) = reg ifTrue: [^RISCTempReg].
	(self concreteRegister: PCReg) = reg ifTrue: [^PCReg].
	(self concreteRegister: VarBaseReg) = reg ifTrue: [^VarBaseReg].
	(self concreteRegister: Scratch0Reg) = reg ifTrue: [^Scratch0Reg].
	self error: 'could not find abstract register'.
	^0

	"({	TempReg. ReceiverResultReg. ClassReg. SendNumArgsReg. Arg0Reg. Arg1Reg.
		FPReg. SPReg.
		LinkReg. RISCTempReg. PCReg. VarBaseReg.
		Scratch0Reg } collect: [:i| self basicNew concreteRegister: i]) sort"

	"While the below works fine in Smalltalk it of course doesn't work in C ;)"
	
	"^reg caseOf: {
		[self concreteRegister: TempReg] -> [TempReg].
		[self concreteRegister: ReceiverResultReg] -> [ReceiverResultReg].
		[self concreteRegister: ClassReg] -> [ClassReg].
		[self concreteRegister: SendNumArgsReg] -> [SendNumArgsReg].
		[self concreteRegister: Arg0Reg] -> [Arg0Reg].
		[self concreteRegister: Arg1Reg] -> [Arg1Reg].
		[self concreteRegister: FPReg] -> [FPReg].
		[self concreteRegister: SPReg] -> [SPReg] }"