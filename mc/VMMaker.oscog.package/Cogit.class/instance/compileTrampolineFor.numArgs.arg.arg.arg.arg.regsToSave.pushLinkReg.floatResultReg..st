initialization
compileTrampolineFor: aRoutine numArgs: numArgs arg: regOrConst0 arg: regOrConst1 arg: regOrConst2 arg: regOrConst3 regsToSave: regMask pushLinkReg: pushLinkReg floatResultReg: resultRegOrNone
	"Generate a trampoline with up to four arguments.  Generate either a call or a jump to aRoutine
	 as requested by callJumpBar.  If generating a call and resultRegOrNone is not NoReg pass the C
	 result back in resultRegOrNone.
	 Hack: a negative value indicates an abstract register, a non-negative value indicates a constant."
	<var: #aRoutine type: #'void *'>
	<inline: false>
	self genSmalltalkToCStackSwitch: pushLinkReg.
	self
		compileCallFor: aRoutine
		numArgs: numArgs
		arg: regOrConst0
		arg: regOrConst1
		arg: regOrConst2
		arg: regOrConst3
		floatResultReg: resultRegOrNone
		regsToSave: regMask.
	backEnd genLoadStackPointers.
	(pushLinkReg and: [backEnd hasLinkRegister])
		ifTrue:
			[backEnd hasPCRegister
				ifTrue: [self PopR: PCReg]
				ifFalse: [self PopR: LinkReg. 
						self RetN: 0]]
		ifFalse: [self RetN: 0]