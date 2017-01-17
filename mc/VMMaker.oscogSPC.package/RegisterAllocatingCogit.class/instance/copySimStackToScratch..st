bytecode generator support
copySimStackToScratch: spillBase
	<inline: true>
	self cCode: [self mem: scratchSimStack cp: simStack y: self simStackSlots * (self sizeof: CogSimStackEntry)]
		inSmalltalk: [0 to: simStackPtr do:
						[:i|
						scratchSimStack at: i put: (simStack at: i) copy]].
	scratchSpillBase := spillBase.
	scratchOptStatus := self cCode: [optStatus] inSmalltalk: [optStatus copy]