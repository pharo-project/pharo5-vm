bytecode generators
genMarshalledSend: selector numArgs: numArgs sendTable: sendTable
	<inline: false>
	<var: #sendTable type: #'sqInt *'>
	(objectMemory isYoung: selector) ifTrue:
		[hasYoungReferent := true].
	self assert: needsFrame.
	numArgs > 2 ifTrue:
		[self MoveCq: numArgs R: SendNumArgsReg].
	self MoveCw: selector R: ClassReg.
	self CallSend: (sendTable at: (numArgs min: NumSendTrampolines - 1)).
	optStatus isReceiverResultRegLive: false.
	^self ssPushRegister: ReceiverResultReg