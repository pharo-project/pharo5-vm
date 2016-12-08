initialization
genMustBeBooleanTrampolineFor: boolean branchBytes: branchBytes called: trampolineName
	<var: #trampolineName type: #'char *'>
	"For RegisterAllocatingCogit we want the address following a conditional branch not to be reachable, so we
	 don't have to generate code to reload registers.  Instead simply convert to an interpreter frame."
	<inline: false>
	self zeroOpcodeIndex.
	"If the objectRepresentation does want true & false to be mobile then we need to record these addresses."
	self assert: (objectRepresentation shouldAnnotateObjectReference: boolean) not.
	self AddCq: boolean R: TempReg.
	^self genTrampolineFor: #ceSendMustBeBooleanTo:interpretingAtDelta:
		called: trampolineName
		numArgs: 2
		arg: TempReg
		arg: (self trampolineArgConstant: branchBytes)
		arg: nil
		arg: nil
		regsToSave: self emptyRegisterMask
		pushLinkReg: true
		resultReg: NoReg
		appendOpcodes: true