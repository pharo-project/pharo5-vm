compile abstract instructions
reconcilePoppingWith: targetEntry
	"Make the state of a targetEntry, a stack entry following a non-inlined special selector
	 send, the same as the corresponding entry (the receiver) along the inlined path."
	<var: #targetEntry type: #'targetEntry *'>
	targetEntry spilled ifTrue:
		[self assert: (self isSameEntryAs: targetEntry).
		 targetEntry liveRegister = NoReg ifTrue:
			[^self].
		 type caseOf: {
				[SSBaseOffset]	-> [cogit MoveMw: offset r: register R: targetEntry liveRegister].
				[SSSpill]		-> [cogit MoveMw: offset r: register R: targetEntry liveRegister].
				[SSConstant]	-> [cogit genMoveConstant: constant R: targetEntry liveRegister].
				[SSRegister]	-> [targetEntry liveRegister ~= register ifTrue:
										[cogit MoveR: register R: targetEntry liveRegister]] }.
		 ^self].
	targetEntry type = SSConstant ifTrue:
		[cogit AddCw: BytesPerWord R: SPReg.
		 ^self].
	targetEntry registerOrNone ~= NoReg ifTrue:
		[cogit PopR: targetEntry registerOrNone.
		 ^self].
	self halt