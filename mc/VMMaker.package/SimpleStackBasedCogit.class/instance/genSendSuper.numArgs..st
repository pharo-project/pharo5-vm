bytecode generators
genSendSuper: selector numArgs: numArgs
	<inline: false>
	self assert: needsFrame.
	self assert: (numArgs between: 0 and: 256). "say"
	self assert: (objectMemory addressCouldBeOop: selector).
	(objectMemory isYoung: selector) ifTrue:
		[hasYoungReferent := true].
	self MoveMw: numArgs * BytesPerWord r: SPReg R: ReceiverResultReg.
	numArgs > 2 ifTrue:
		[self MoveCq: numArgs R: SendNumArgsReg].
	self MoveCw: selector R: ClassReg.
	self CallSend: (superSendTrampolines at: (numArgs min: NumSendTrampolines - 1)).
	usesMethodClass := true.
	self flag: 'currently caller pushes result'.
	self PushR: ReceiverResultReg.
	^0