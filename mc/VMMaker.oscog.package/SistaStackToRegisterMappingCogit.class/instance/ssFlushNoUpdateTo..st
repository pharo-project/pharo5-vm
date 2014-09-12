simulation stack
ssFlushNoUpdateTo: index
	"This version of ssFlushTo: does /not/ update the simulation stack; it merely generates the spill code.
	 It is used to spill all values to the stack on a rare failing branch (the class trap) when we don't want to
	 flush the stack on the main path and hence mustn't update the simulation stack if there is no spill."
	<var: 'copiedEntry' type: #CogSimStackEntry>
	self assert: needsFrame.
	methodOrBlockNumTemps to: simSpillBase - 1 do:
		[:i| self assert: (self simStackAt: i) spilled].
	simSpillBase <= index ifTrue:
		[(simSpillBase max: 0) to: index do:
			[:i| | copiedEntry |
			copiedEntry := self cCode: [simStack at: index]
								inSmalltalk: [(simStack at: index) copy].
			copiedEntry
				ensureSpilledAt: (self frameOffsetOfTemporary: i)
				from: FPReg]]