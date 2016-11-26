compile abstract instructions
reconcileWith: simStackEntry
	"Make the state of each simStackEntry, a stack entry along the non-inlined special selector path,
	 the same as the corresponding simStackEntry along the inlined path (the receiver)."
	<var: #simStackEntry type: #'SimStackEntry *'>
	type = SSConstant ifTrue:
		[cogit AddCw: BytesPerWord R: SPReg.
		 ^self].
	liveRegister ~= NoReg ifTrue:
		[simStackEntry popToReg: liveRegister.
		 ^self].
	type = SSRegister ifTrue:
		[simStackEntry popToReg: register.
		 ^self].
	self halt