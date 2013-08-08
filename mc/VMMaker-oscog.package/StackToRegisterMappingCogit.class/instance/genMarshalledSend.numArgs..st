bytecode generators
genMarshalledSend: selector numArgs: numArgs
	<inline: false>
	(objectMemory isYoung: selector) ifTrue:
		[hasYoungReferent := true].
	self assert: needsFrame.
	numArgs > 2 ifTrue:
		[self MoveCq: numArgs R: SendNumArgsReg].
	self MoveCw: selector R: ClassReg.
	self CallSend: (sendTrampolines at: (numArgs min: NumSendTrampolines - 1)).
	optStatus isReceiverResultRegLive: false.
	^self ssPushRegister: ReceiverResultReg