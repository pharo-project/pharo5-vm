compile abstract instructions
reconcilePoppingWith: simStackEntry
	"Make the state of a simStackEntry, a stack entry along the inlined special selector path,
	 the same as the corresponding simStackEntry along the non-inlined path (the receiver)."
	<var: #simStackEntry type: #'SimStackEntry *'>
	simStackEntry type = SSConstant ifTrue:
		[cogit AddCw: BytesPerWord R: SPReg.
		 ^self].
	simStackEntry registerOrNone ~= NoReg ifTrue:
		[cogit PopR: simStackEntry registerOrNone.
		 ^self].
	self halt