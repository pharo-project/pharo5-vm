initialization
generateSendTrampolines
	0 to: NumSendTrampolines - 2 do:
		[:numArgs|
		ordinarySendTrampolines
			at: numArgs
			put: (self genTrampolineFor: #ceSend:super:to:numArgs:
					  called: (self trampolineName: 'ceSend' numArgs: numArgs)
					  arg: ClassReg
					  arg: 0
					  arg: ReceiverResultReg
					  arg: numArgs)].
	ordinarySendTrampolines
		at: NumSendTrampolines - 1
		put: (self genTrampolineFor: #ceSend:super:to:numArgs:
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
					put: (self genTrampolineFor: #ceDynamicSuperSend:to:numArgs:
							  called: (self trampolineName: 'ceDynSuperSend' numArgs: numArgs)
							  arg: ClassReg
							  arg: ReceiverResultReg
							  arg: numArgs)].
			dynamicSuperSendTrampolines
				at: NumSendTrampolines - 1
				put: (self genTrampolineFor: #ceDynamicSuperSend:to:numArgs:
							called: (self trampolineName: 'ceDynSuperSend' numArgs: -1)
							arg: ClassReg
							arg: ReceiverResultReg
							arg: SendNumArgsReg).
			0 to: NumSendTrampolines - 2 do:
				[:numArgs|
				selfSendTrampolines
					at: numArgs
					put: (self genTrampolineFor: #ceSelfSend:to:numArgs:
							  called: (self trampolineName: 'ceSelfSend' numArgs: numArgs)
							  arg: ClassReg
							  arg: ReceiverResultReg
							  arg: numArgs)].
			selfSendTrampolines
				at: NumSendTrampolines - 1
				put: (self genTrampolineFor: #ceSelfSend:to:numArgs:
							called: (self trampolineName: 'ceSelfSend' numArgs: -1)
							arg: ClassReg
							arg: ReceiverResultReg
							arg: SendNumArgsReg)].
	0 to: NumSendTrampolines - 2 do:
		[:numArgs|
		superSendTrampolines
			at: numArgs
			put: (self genTrampolineFor: #ceSend:super:to:numArgs:
					  called: (self trampolineName: 'ceSuperSend' numArgs: numArgs)
					  arg: ClassReg
					  arg: 1
					  arg: ReceiverResultReg
					  arg: numArgs)].
	superSendTrampolines
		at: NumSendTrampolines - 1
		put: (self genTrampolineFor: #ceSend:super:to:numArgs:
					called: (self trampolineName: 'ceSuperSend' numArgs: -1)
					arg: ClassReg
					arg: 1
					arg: ReceiverResultReg
					arg: SendNumArgsReg).
	firstSend := ordinarySendTrampolines at: 0.
	lastSend := superSendTrampolines at: NumSendTrampolines - 1