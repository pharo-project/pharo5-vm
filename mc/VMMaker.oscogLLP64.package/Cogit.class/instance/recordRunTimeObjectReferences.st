initialization
recordRunTimeObjectReferences
	<var: #instruction type: #'AbstractInstruction *'>
	0 to: opcodeIndex - 1 do:
		[:i| | instruction |
		instruction := self abstractInstructionAt: i.
		instruction annotation = IsObjectReference ifTrue:
			[self assert: runtimeObjectRefIndex < NumObjRefsInRuntime.
			 self assert: hasYoungReferent not.
			 hasYoungReferent ifTrue:
				[self error: 'attempt to generate run-time routine containing young object reference.  Cannot initialize Cogit run-time.'].
			 objectReferencesInRuntime
				at: runtimeObjectRefIndex
				put: instruction mapEntryAddress asUnsignedInteger.
			 runtimeObjectRefIndex := runtimeObjectRefIndex + 1]]