initialization
genCallPICEnilopmartNumArgs: numArgs
	"Generate special versions of the ceCallCogCodePopReceiverAndClassRegs
	 enilopmart that also pop register args from the stack to undo the pushing of
	 register args in the abort/miss trampolines."
	<returnTypeC: 'void (*genCallPICEnilopmartNumArgs(sqInt numArgs))(void)'>
	| size endAddress enilopmart |
	self zeroOpcodeIndex.
	backEnd hasVarBaseRegister ifTrue:
		[self MoveCq: self varBaseAddress R: VarBaseReg]. "Must happen first; value may be used in genLoadStackPointers"
	backEnd genLoadStackPointers.
	self PopR: ClassReg. "cacheTag"
	self PopR: TempReg. "entry-point"
	self PopR: (backEnd hasLinkRegister ifTrue: [LinkReg] ifFalse: [SendNumArgsReg]). "retpc"
	numArgs > 0 ifTrue:
		[numArgs > 1 ifTrue:
			[self PopR: Arg1Reg.
			 self assert: self numRegArgs = 2].
		 self PopR: Arg0Reg].
	self PopR: ReceiverResultReg.
	backEnd hasLinkRegister ifFalse: [self PushR: SendNumArgsReg]. "retpc"
	self JumpR: TempReg.
	self computeMaximumSizes.
	size := self generateInstructionsAt: methodZoneBase.
	endAddress := self outputInstructionsAt: methodZoneBase.
	self assert: methodZoneBase + size = endAddress.
	enilopmart := methodZoneBase.
	methodZoneBase := self alignUptoRoutineBoundary: endAddress.
	backEnd stopsFrom: endAddress to: methodZoneBase - 1.
	self recordGeneratedRunTime: (self trampolineName: 'ceCallPIC' numRegArgs: numArgs) address: enilopmart.
	^self cCoerceSimple: enilopmart to: #'void (*)(void)'