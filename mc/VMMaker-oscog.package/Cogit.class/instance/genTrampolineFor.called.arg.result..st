initialization
genTrampolineFor: aRoutine called: aString arg: regOrConst0 result: resultReg
	"Generate a trampoline with one argument that answers a result.
	 Hack: a negative value indicates an abstract register, a non-negative value indicates a constant."
	<var: #aRoutine type: #'void *'>
	<var: #aString type: #'char *'>
	^self
		genTrampolineFor: aRoutine
		called: aString
		callJumpBar: true
		numArgs: 1
		arg: regOrConst0
		arg: nil
		arg: nil
		arg: nil
		saveRegs: false
		resultReg: resultReg
		appendOpcodes: false