initialization
generateNewspeakSendTrampolines
	"Self send, dynamic super send, implicit receiver send, and outer send"
	<option: #NewspeakVM>
	0 to: NumSendTrampolines - 1 do:
		[:numArgs|
		selfSendTrampolines
			at: numArgs
			put: (self genTrampolineFor: #ceSelfSend:to:numArgs:
					  called: (self trampolineName: 'ceSelfSend' numArgs: numArgs)
					  arg: ClassReg
					  arg: ReceiverResultReg
					  arg: (self numArgsOrSendNumArgsReg: numArgs))].

	0 to: NumSendTrampolines - 1 do:
		[:numArgs|
		dynamicSuperSendTrampolines
			at: numArgs
			put: (self genTrampolineFor: #ceDynamicSuperSend:to:numArgs:
					  called: (self trampolineName: 'ceDynSuperSend' numArgs: numArgs)
					  arg: ClassReg
					  arg: ReceiverResultReg
					  arg: (self numArgsOrSendNumArgsReg: numArgs))].

	0 to: NumSendTrampolines - 1 do:
		[:numArgs|
		implicitReceiverSendTrampolines
			at: numArgs
			put: (self 
				genNSSendTrampolineFor: #ceImplicitReceiverSend:receiver:
				numArgs: numArgs
				called: (self trampolineName: 'ceImplicitReceiverSend' numArgs: numArgs))].

	0 to: NumSendTrampolines - 1 do:
		[:numArgs|
		outerSendTrampolines
			at: numArgs
			put: (self 
				genNSSendTrampolineFor: #ceOuterSend:receiver:
				numArgs: numArgs
				called: (self trampolineName: 'ceOuterSend' numArgs: numArgs))].

