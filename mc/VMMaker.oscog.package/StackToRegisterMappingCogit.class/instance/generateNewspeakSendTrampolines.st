initialization
generateNewspeakSendTrampolines
	"Self send, dynamic super send, implicit receiver send, and outer send."
	"Override to generate code to push the register arg(s) for <= numRegArg arity sends."
	<option: #NewspeakVM>
	0 to: NumSendTrampolines - 1 do:
		[:numArgs|
		selfSendTrampolines
			at: numArgs
			put: (self genSendTrampolineFor: #ceSelfSend:to:numArgs:
					  numArgs: numArgs
					  called: (self trampolineName: 'ceSelfSend' numArgs: numArgs)
					  arg: ClassReg
					  arg: ReceiverResultReg
					  arg: (self numArgsOrSendNumArgsReg: numArgs))].

	0 to: NumSendTrampolines - 1 do:
		[:numArgs|
		dynamicSuperSendTrampolines
			at: numArgs
			put: (self genSendTrampolineFor: #ceDynamicSuperSend:to:numArgs:
					  numArgs: numArgs
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
				called: (self trampolineName: 'ceOuterSend' numArgs: numArgs))]