compile abstract instructions
reconcilePoppingWith: targetEntry
	"Make the state of a targetEntry, a stack entry following a non-inlined special selector
	 send, the same as the corresponding entry (the receiver) along the inlined path."
	<var: #targetEntry type: #'SimStackEntry *'>
	| targetReg |
	spilled = targetEntry spilled ifTrue:
		[self assert: (targetEntry spilled
						ifTrue: [self isSameEntryAs: targetEntry]
						ifFalse: [targetEntry registerOrNone ~= NoReg]).
		 (targetReg := targetEntry registerOrNone) = NoReg ifTrue:
			[^self].
		 type caseOf: {
				[SSBaseOffset]	-> [cogit MoveMw: offset r: register R: targetReg].
				[SSSpill]		-> [cogit MoveMw: offset r: register R: targetReg].
				[SSConstant]	-> [cogit genMoveConstant: constant R: targetReg].
				[SSRegister]	-> [targetReg ~= register ifTrue:
										[cogit MoveR: register R: targetReg]] }.
		 ^self].
	self assert: spilled.
	(targetEntry type ~= SSConstant
	 and: [(targetReg := targetEntry registerOrNone) ~= NoReg])
		ifTrue: [cogit PopR: targetReg]
		ifFalse: [cogit AddCq: objectRepresentation wordSize R: SPReg]