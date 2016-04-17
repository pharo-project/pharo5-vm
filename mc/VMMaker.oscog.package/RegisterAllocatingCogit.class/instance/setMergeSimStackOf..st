bytecode generator support
setMergeSimStackOf: fixup
	<var: #fixup type: #'BytecodeFixup *'>
	self assert: nextFixup < numFixups.
	self moveSimStackConstantsToRegisters.
	self cCode: [fixup mergeSimStack: mergeSimStacksBase + (nextFixup * self simStackSlots * (self sizeof: CogSimStackEntry))].
	nextFixup := nextFixup + 1.
	self cCode: [self mem: fixup mergeSimStack cp: self simStackSlots * (self sizeof: CogSimStackEntry) y: simStack]
		inSmalltalk: [fixup mergeSimStack: self copySimStack]