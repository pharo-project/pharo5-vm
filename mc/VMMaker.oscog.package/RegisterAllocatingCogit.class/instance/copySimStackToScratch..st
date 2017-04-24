bytecode generator support
copySimStackToScratch: spillBase
	<inline: true>
	scratchBytecodePC = bytecodePC ifTrue:
		[^self].
	scratchBytecodePC := bytecodePC.
	self cCode: [self mem: scratchSimStack cp: simStack y: self simStackSlots * (self sizeof: CogSimStackEntry)]
		inSmalltalk: [0 to: simStackPtr do:
						[:i|
						scratchSimStack at: i put: (simStack at: i) copy]].
	scratchSpillBase := spillBase.
	scratchSimSelf := self cCode: [simSelf] inSmalltalk: [simSelf copy]