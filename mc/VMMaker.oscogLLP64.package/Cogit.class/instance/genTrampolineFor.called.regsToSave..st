initialization
genTrampolineFor: aRoutine called: aString regsToSave: regMask
	"Generate a trampoline with no arguments"
	<var: #aRoutine type: #'void *'>
	<var: #aString type: #'char *'>
	^self
		genTrampolineFor: aRoutine
		called: aString
		numArgs: 0
		arg: nil
		arg: nil
		arg: nil
		arg: nil
		regsToSave: regMask
		pushLinkReg: true
		resultReg: NoReg
		appendOpcodes: false