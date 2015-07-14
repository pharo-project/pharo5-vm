initialization
generateNewspeakSendTrampolines
	"Self send, dynamic super send, implicit receiver send, and outer send"
	<option: #NewspeakVM>
	0 to: NumSendTrampolines - 1 do:
		[:numArgs|
		selfSendTrampolines
			at: numArgs
			put: (self 
				genNSSendTrampolineFor: #ceSelfSend:receiver:
				numArgs: numArgs enclosingObjectCheck: false
				called: (self trampolineName: 'ceSelfSend' numArgs: numArgs))].

	0 to: NumSendTrampolines - 1 do:
		[:numArgs|
		dynamicSuperSendTrampolines
			at: numArgs
			put: (self 
				genNSSendTrampolineFor: #ceDynamicSuperSend:receiver:
				numArgs: numArgs enclosingObjectCheck: false
				called: (self trampolineName: 'ceDynamicSuperSend' numArgs: numArgs))].

	0 to: NumSendTrampolines - 1 do:
		[:numArgs|
		implicitReceiverSendTrampolines
			at: numArgs
			put: (self 
				genNSSendTrampolineFor: #ceImplicitReceiverSend:receiver:
				numArgs: numArgs enclosingObjectCheck: true
				called: (self trampolineName: 'ceImplicitReceiverSend' numArgs: numArgs))].

	0 to: NumSendTrampolines - 1 do:
		[:numArgs|
		outerSendTrampolines
			at: numArgs
			put: (self 
				genNSSendTrampolineFor: #ceOuterSend:receiver:
				numArgs: numArgs enclosingObjectCheck: true
				called: (self trampolineName: 'ceOuterSend' numArgs: numArgs))].

