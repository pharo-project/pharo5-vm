initialization
genTrampolineFor: aRoutine called: aString floatArg: regOrConst0 result: resultReg
	"Generate a trampoline with one argument that answers a result.
	 Hack: a negative value indicates an abstract register, a non-negative value indicates a constant."
	<var: #aRoutine type: #'void *'>
	<var: #aString type: #'char *'>
	^self
		genTrampolineFor: aRoutine
		called: aString
		numArgs: 1
		floatArg: regOrConst0
		floatArg: nil
		floatArg: nil
		floatArg: nil
		regsToSave: self emptyRegisterMask
		pushLinkReg: true
		resultReg: resultReg
		appendOpcodes: false