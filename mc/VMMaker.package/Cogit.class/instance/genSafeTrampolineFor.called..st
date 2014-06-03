initialization
genSafeTrampolineFor: aRoutine called: aString
	"Generate a trampoline with no arguments that will
	 save and restore all registers around the call"
	<var: #aRoutine type: #'void *'>
	<var: #aString type: #'char *'>
	^self
		genTrampolineFor: aRoutine
		called: aString
		callJumpBar: true
		numArgs: 0
		arg: nil
		arg: nil
		arg: nil
		arg: nil
		saveRegs: true
		resultReg: nil
		appendOpcodes: false