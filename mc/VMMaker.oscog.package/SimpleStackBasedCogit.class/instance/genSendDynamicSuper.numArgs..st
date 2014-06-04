bytecode generators
genSendDynamicSuper: selector numArgs: numArgs
	(objectMemory isYoung: selector) ifTrue:
		[hasYoungReferent := true].
	self assert: needsFrame.
	self MoveMw: numArgs * BytesPerWord r: SPReg R: ReceiverResultReg.
	numArgs > 2 ifTrue:
		[self MoveCq: numArgs R: SendNumArgsReg].
	self MoveCw: selector R: ClassReg.
	self CallSend: (dynamicSuperSendTrampolines at: (numArgs min: NumSendTrampolines - 1)).
	usesMethodClass := true.
	self flag: 'currently caller pushes result'.
	self PushR: ReceiverResultReg.
	^0