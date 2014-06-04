initialization
genEnterPICEnilopmartNumArgs: numArgs
	"Generate special versions of the ceEnterCogCodePopReceiverAndClassRegs
	 enilopmart that also pop register args from the stack to undo the pushing of
	 register args in the abort/miss trampolines."
	<returnTypeC: 'void (*genEnterPICEnilopmartNumArgs(sqInt numArgs))(void)'>
	| size endAddress enilopmart |
	opcodeIndex := 0.
	backEnd genLoadStackPointers.
	self PopR: ClassReg. "cacheTag"
	self PopR: TempReg. "entry-point"
	self PopR: SendNumArgsReg. "retpc"
	numArgs > 0 ifTrue:
		[numArgs > 1 ifTrue:
			[self PopR: Arg1Reg.
			 self assert: self numRegArgs = 2].
		 self PopR: Arg0Reg].
	self PopR: ReceiverResultReg.
	self PushR: SendNumArgsReg. "retpc"
	self JumpR: TempReg.
	self computeMaximumSizes.
	size := self generateInstructionsAt: methodZoneBase.
	endAddress := self outputInstructionsAt: methodZoneBase.
	self assert: methodZoneBase + size = endAddress.
	enilopmart := methodZoneBase.
	methodZoneBase := self alignUptoRoutineBoundary: endAddress.
	backEnd nopsFrom: endAddress to: methodZoneBase - 1.
	self recordGeneratedRunTime: (self trampolineName: 'ceEnterPIC' numArgs: numArgs) address: enilopmart.
	^self cCoerceSimple: enilopmart to: #'void (*)(void)'