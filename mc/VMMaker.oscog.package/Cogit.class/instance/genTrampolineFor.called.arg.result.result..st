initialization
genTrampolineFor: aRoutine called: aString arg: regOrConst0 result: resultReg result: resultReg2
	"Generate a trampoline with one argument that answers a result.
	 Hack: a negative value indicates an abstract register, a non-negative value indicates a constant."
	<option: #LowcodeVM>
	<var: #aRoutine type: #'void *'>
	<var: #aString type: #'char *'>
	^self
		genTrampolineFor: aRoutine
		called: aString
		numArgs: 1
		arg: regOrConst0
		arg: nil
		arg: nil
		arg: nil
		regsToSave: self emptyRegisterMask
		pushLinkReg: true
		resultReg: resultReg
		resultReg: resultReg2
		appendOpcodes: false