initialization
genTrampolineFor: aRoutine called: aString arg: regOrConst0 arg: regOrConst1 regsToSave: regMask
	"Generate a trampoline with two arguments.
	 Hack: a negative value indicates an abstract register, a non-negative value indicates a constant."
	<var: #aRoutine type: #'void *'>
	<var: #aString type: #'char *'>
	^self
		genTrampolineFor: aRoutine
		called: aString
		numArgs: 2
		arg: regOrConst0
		arg: regOrConst1
		arg: nil
		arg: nil
		regsToSave: regMask
		pushLinkReg: true
		resultReg: NoReg
		appendOpcodes: false