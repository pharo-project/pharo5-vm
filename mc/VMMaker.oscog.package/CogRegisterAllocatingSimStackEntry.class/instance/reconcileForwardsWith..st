compile abstract instructions
reconcileForwardsWith: targetEntry
	"Make the state of the receiver, a stack entry at the end of a basic block,
	 the same as the corresponding simStackEntry at the target of a preceding
	 jump to the beginning of the next basic block."
	<var: #targetEntry type: #'targetEntry *'>
	| targetReg |
	(targetReg := targetEntry registerOrNone) = NoReg ifTrue:
		[self assert: (self isSameEntryAs: targetEntry).
		 ^self].
	liveRegister ~= NoReg ifTrue:
		[liveRegister ~= targetReg ifTrue:
			[cogit MoveR: liveRegister R: targetReg].
		 (spilled and: [targetEntry spilled not]) ifTrue:
			[cogit AddCq: objectRepresentation wordSize R: SPReg].
		 ^self].
	spilled
		ifTrue:
			[targetEntry spilled ifTrue:
				[cogit PopR: targetReg. "KISS; generate the least number of instructions..."
				 ^self]]
		ifFalse:
			[self deny: targetEntry spilled].
	type caseOf: {
		[SSBaseOffset]	-> [cogit MoveMw: offset r: register R: targetReg].
		[SSSpill]		-> [cogit MoveMw: offset r: register R: targetReg].
		[SSConstant]	-> [cogit genMoveConstant: constant R: targetReg].
		[SSRegister]	-> [register ~= targetReg ifTrue:
								[cogit MoveR: register R: targetReg]] }