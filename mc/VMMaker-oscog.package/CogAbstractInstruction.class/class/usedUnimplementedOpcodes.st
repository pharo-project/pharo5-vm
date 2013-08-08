verification
usedUnimplementedOpcodes
	"Check for uses of unimplemented opcodes"
	"self subclasses collect: [:compiler| {compiler. compiler usedUnimplementedOpcodes}]"
	| genericUnimplementedOpcodeBindings specificUnimplementedOpcodeBindings |
	genericUnimplementedOpcodeBindings := Set new.
	specificUnimplementedOpcodeBindings := Set new.
	self unimplementedOpcodes do:
		[:arrayOfOpcodes|
		arrayOfOpcodes do:
			[:opcode|
			(self bindingOf: opcode)
				ifNotNil: [:b| specificUnimplementedOpcodeBindings add: b]
				ifNil: [genericUnimplementedOpcodeBindings add: (CogRTLOpcodes bindingOf: opcode)]]].
	^ { (SystemNavigation new allCallsOn: genericUnimplementedOpcodeBindings localToPackage: #VMMaker)
			inject: Set new
			into:  [:them :methodRef| "These should be in Cogit's abstract instructions category"
				them
					addAll: (SystemNavigation new allCallsOn: methodRef method selector localToPackage: #VMMaker);
					yourself].
		SystemNavigation new allCallsOn: specificUnimplementedOpcodeBindings localToPackage: #VMMaker }