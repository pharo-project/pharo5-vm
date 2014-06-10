initialization
genSafeTrampolineFor: aRoutine called: aString arg: regOrConst0
	"Generate a trampoline with one argument that will
	 save and restore all registers around the call"
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
		saveRegs: true
		pushLinkReg: true
		resultReg: nil
		appendOpcodes: false