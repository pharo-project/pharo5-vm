bytecode generators
genSend: selector numArgs: numArgs
	<inline: false>
	(objectMemory isYoung: selector) ifTrue:
		[hasYoungReferent := true].
	self assert: needsFrame.
	self assert: (numArgs between: 0 and: 256). "say"
	self assert: (objectMemory addressCouldBeOop: selector).
	self MoveMw: numArgs * BytesPerWord r: SPReg R: ReceiverResultReg.
	numArgs > 2 ifTrue:
		[self MoveCq: numArgs R: SendNumArgsReg].
	self MoveCw: selector R: ClassReg.
	self CallSend: (sendTrampolines at: (numArgs min: NumSendTrampolines - 1)).
	self flag: 'currently caller pushes result'.
	self PushR: ReceiverResultReg.
	^0