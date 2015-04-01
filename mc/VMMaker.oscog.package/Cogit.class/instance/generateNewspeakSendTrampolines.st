initialization
generateNewspeakSendTrampolines
	"Self send, dynamic super send, and implicit receiver send. TODO: outer send."
	<option: #NewspeakVM>
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
					arg: SendNumArgsReg).

	0 to: NumSendTrampolines - 2 do:
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
		implicitReceiverSendTrampolines
			at: numArgs
			put: (self 
				genNSSendTrampolineFor: #ceImplicitReceiverSend:receiver:
				numArgs: numArgs
				called: (self trampolineName: 'ceImplicitReceiverSend' numArgs: numArgs))].
	implicitReceiverSendTrampolines
		at: NumSendTrampolines - 1
		put: (self 
			genNSSendTrampolineFor: #ceImplicitReceiverSend:receiver:
			numArgs: self numRegArgs + 1
			called: (self trampolineName: 'ceImplicitReceiverSend' numArgs: -1)).