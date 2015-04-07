initialization
generateSendTrampolines
	"Override to generate code to push the register arg(s) for <= numRegArg arity sends."
	0 to: NumSendTrampolines - 2 do:
		[:numArgs|
		ordinarySendTrampolines
			at: numArgs
			put: (self genSendTrampolineFor: #ceSend:super:to:numArgs:
					  numArgs: numArgs
					  called: (self trampolineName: 'ceSend' numArgs: numArgs)
					  arg: ClassReg
					  arg: 0
					  arg: ReceiverResultReg
					  arg: numArgs)].
	ordinarySendTrampolines
		at: NumSendTrampolines - 1
		put: (self genSendTrampolineFor: #ceSend:super:to:numArgs:
					numArgs: self numRegArgs + 1
					called: (self trampolineName: 'ceSend' numArgs: -1)
					arg: ClassReg
					arg: 0
					arg: ReceiverResultReg
					arg: SendNumArgsReg).

	"Generate these in the middle so they are within [firstSend, lastSend]."
	self cppIf: NewspeakVM ifTrue: [self generateNewspeakSendTrampolines].
	self cppIf: BytecodeSetHasDirectedSuperSend ifTrue:
		[0 to: NumSendTrampolines - 2 do:
			[:numArgs|
			directedSuperSendTrampolines
				at: numArgs
				put: (self genSendTrampolineFor: #ceSend:above:to:numArgs:
						  numArgs: numArgs
						  called: (self trampolineName: 'ceDirectedSuperSend' numArgs: numArgs)
						  arg: ClassReg
						  arg: TempReg
						  arg: ReceiverResultReg
						  arg: numArgs)].
		directedSuperSendTrampolines
			at: NumSendTrampolines - 1
			put: (self genSendTrampolineFor: #ceSend:above:to:numArgs:
						numArgs: self numRegArgs + 1
						called: (self trampolineName: 'ceDirectedSuperSend' numArgs: -1)
						arg: ClassReg
						arg: TempReg
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
	firstSend := ordinarySendTrampolines at: 0.
	lastSend := superSendTrampolines at: NumSendTrampolines - 1