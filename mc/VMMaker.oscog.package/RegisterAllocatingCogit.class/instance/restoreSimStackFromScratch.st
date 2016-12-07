bytecode generator support
restoreSimStackFromScratch
	<inline: true>
	self cCode: [self mem: simStack cp: scratchSimStack y: self simStackSlots * (self sizeof: CogSimStackEntry)]
		inSmalltalk: [0 to: simStackPtr do:
						[:i|
						simStack at: i put: (scratchSimStack at: i)]].
	simSpillBase := scratchSpillBase.
	optStatus := scratchOptStatus