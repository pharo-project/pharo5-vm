as yet unclassified
doBranch: taken offset: offset
	| nextPC |
	pc := pc + OneInstruction.
	nextPC := pc + offset. "Branch target is relative to the delay slot."
	self executeDelaySlot.
	taken ifTrue: [pc := nextPC - OneInstruction "Account for general increment"].