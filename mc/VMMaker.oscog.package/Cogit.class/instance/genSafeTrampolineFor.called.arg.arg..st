initialization
genSafeTrampolineFor: aRoutine called: aString arg: regOrConst0 arg: regOrConst1
	"Generate a trampoline with two arguments that
	 will save and restore all registers around the call"
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
		saveRegs: true
		pushLinkReg: true
		resultReg: nil
		appendOpcodes: false