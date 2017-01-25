compile abstract instructions
reconcileBackwardsWith: targetEntry
	"Make the state of the receiver, a stack entry at a backward jump,
	 the same as the corresponding simStackEntry at the target of the jump"
	<var: #targetEntry type: #'SimStackEntry *'>
	| targetReg |
	(targetReg := targetEntry registerOrNone) = NoReg ifTrue:
		[^self].
	targetEntry type = SSConstant ifTrue:
		[self assert: (type = SSConstant and: [constant = targetEntry constant]).
		 ^self].
	liveRegister ~= NoReg ifTrue:
		[liveRegister ~= targetReg ifTrue:
			[cogit MoveR: liveRegister R: targetReg].
		 ^self].
	type caseOf: {
		[SSBaseOffset]	-> [cogit MoveMw: offset r: register R: targetReg].
		[SSSpill]		-> [cogit MoveMw: offset r: register R: targetReg].
		[SSConstant]	-> [cogit genMoveConstant: constant R: targetReg].
		[SSRegister]	-> [register ~= targetReg ifTrue:
								[cogit MoveR: register R: targetReg]] }