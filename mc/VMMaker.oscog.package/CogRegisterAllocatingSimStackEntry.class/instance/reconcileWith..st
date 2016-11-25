compile abstract instructions
reconcileWith: simStackEntry
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