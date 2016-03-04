initialization
genReturnTrampolineFor: aRoutine  called: aString arg: regOrConst0
	"Generate a trampoline for a routine used as a return address, that has one argument.
	 Hack: a negative value indicates an abstract register, a non-negative value indicates a constant."
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
		pushLinkReg: false "Since the routine is reached by a return instruction it should /not/ push the link register."
		resultReg: NoReg
		appendOpcodes: false