initialization
genTrampolineFor: aRoutine called: aString arg: regOrConst0 arg: regOrConst1 arg: regOrConst2 result: resultReg
	"Generate a trampoline with two arguments that answers a result.
	 Hack: a negative value indicates an abstract register, a non-negative value indicates a constant."
	<var: #aRoutine type: #'void *'>
	<var: #aString type: #'char *'>
	^self
		genTrampolineFor: aRoutine
		called: aString
		numArgs: 3
		arg: regOrConst0
		arg: regOrConst1
		arg: regOrConst2
		arg: nil
		regsToSave: self emptyRegisterMask
		pushLinkReg: true
		resultReg: resultReg
		appendOpcodes: false