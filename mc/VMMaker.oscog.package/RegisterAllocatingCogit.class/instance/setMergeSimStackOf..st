bytecode generator support
setMergeSimStackOf: fixup
	<var: #fixup type: #'BytecodeFixup *'>
	self assert: nextFixup <= numFixups.
	self moveSimStackConstantsToRegisters.
	self cCode: [fixup mergeSimStack: mergeSimStacksBase + (nextFixup * self simStackSlots * (self sizeof: CogSimStackEntry))].
	fixup
		simStackPtr: simStackPtr;
		isReceiverResultRegSelf: optStatus isReceiverResultRegLive.
	nextFixup := nextFixup + 1.
	self cCode: [self mem: fixup mergeSimStack cp: simStack y: self simStackSlots * (self sizeof: CogSimStackEntry)]
		inSmalltalk: [fixup mergeSimStack: self copySimStack]