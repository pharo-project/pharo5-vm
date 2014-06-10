initialization
generateSendTrampolines
	"Override to generate code to push the register arg(s) for <= numRegArg arity sends."
	0 to: NumSendTrampolines - 2 do:
		[:numArgs|
		sendTrampolines
			at: numArgs
			put: (self genSendTrampolineFor: #ceSend:super:to:numArgs:
					  numArgs: numArgs
					  called: (self trampolineName: 'ceSend' numArgs: numArgs)
					  arg: ClassReg
					  arg: 0
					  arg: ReceiverResultReg
					  arg: numArgs)].
	sendTrampolines
		at: NumSendTrampolines - 1
		put: (self genSendTrampolineFor: #ceSend:super:to:numArgs:
					numArgs: self numRegArgs + 1
					called: (self trampolineName: 'ceSend' numArgs: -1)
					arg: ClassReg
					arg: 0
					arg: ReceiverResultReg
					arg: SendNumArgsReg).
	self cppIf: NewspeakVM
		ifTrue:
			[0 to: NumSendTrampolines - 2 do:
				[:numArgs|
				dynamicSuperSendTrampolines
					at: numArgs
					put: (self genSendTrampolineFor: #ceDynamicSuperSend:to:numArgs:
							  numArgs: numArgs
							  called: (self trampolineName: 'ceDynSuperSend' numArgs: numArgs)
							  arg: ClassReg
							  arg: ReceiverResultReg
							  arg: numArgs)].
			dynamicSuperSendTrampolines
				at: NumSendTrampolines - 1
				put: (self genSendTrampolineFor: #ceDynamicSuperSend:to:numArgs:
							numArgs: self numRegArgs + 1
							called: (self trampolineName: 'ceDynSuperSend' numArgs: -1)
							arg: ClassReg
							arg: ReceiverResultReg
							arg: SendNumArgsReg)].
	0 to: NumSendTrampolines - 2 do:
		[:numArgs|
		superSendTrampolines
			at: numArgs
			put: (self genSendTrampolineFor: #ceSend:super:to:numArgs:
					  numArgs: numArgs
					  called: (self trampolineName: 'ceSuperSend' numArgs: numArgs)
					  arg: ClassReg
					  arg: 1
					  arg: ReceiverResultReg
					  arg: numArgs)].
	superSendTrampolines
		at: NumSendTrampolines - 1
		put: (self genSendTrampolineFor: #ceSend:super:to:numArgs:
					numArgs: self numRegArgs + 1
					called: (self trampolineName: 'ceSuperSend' numArgs: -1)
					arg: ClassReg
					arg: 1
					arg: ReceiverResultReg
					arg: SendNumArgsReg).
	firstSend := sendTrampolines at: 0.
	lastSend := superSendTrampolines at: NumSendTrampolines - 1