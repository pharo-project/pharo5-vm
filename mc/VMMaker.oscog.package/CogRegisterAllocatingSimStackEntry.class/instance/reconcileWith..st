compile abstract instructions
reconcileWith: targetEntry
	"Make the state of the receiver, a stack entry at a backward jump,
	 the same as the corresponding simStackEntry at the target of the jump"
	<var: #targetEntry type: #'targetEntry *'>
	targetEntry liveRegister = NoReg ifTrue:
		[^self].
	targetEntry type = SSConstant ifTrue:
		[self assert: (type = SSConstant and: [constant = targetEntry constant]).
		 ^self].
	liveRegister ~= NoReg ifTrue:
		[liveRegister ~= targetEntry liveRegister ifTrue:
			[cogit MoveR: liveRegister R: targetEntry liveRegister].
		 ^self].
	type caseOf: {
		[SSBaseOffset]	-> [cogit MoveMw: offset r: register R: targetEntry liveRegister].
		[SSSpill]		-> [cogit MoveMw: offset r: register R: targetEntry liveRegister].
		[SSConstant]	-> [cogit genMoveConstant: constant R: targetEntry liveRegister].
		[SSRegister]	-> [register ~= targetEntry liveRegister ifTrue:
								[cogit MoveR: register R: targetEntry liveRegister]] }