initialization
generateObjectRepresentationTrampolines
	"Do the store check.  Answer the argument for the benefit of the code generator;
	 ReceiverResultReg may be caller-saved and hence smashed by this call.  Answering
	 it allows the code generator to reload ReceiverResultReg cheaply.
	 In Spur the only thing we leave to the run-time is adding the receiver to the
	 remembered set and setting its isRemembered bit."
	self 
		cppIf: IMMUTABILITY
		ifTrue: 
			[ 0 to: self numStoreTrampolines do:
				[ :instVarIndex |
					ceStoreTrampolines
						at: instVarIndex
						put: (self 
							genStoreTrampolineCalled: (cogit 
								trampolineName: 'ceStoreTrampoline' 
								numArgs: instVarIndex 
								limit: self numStoreTrampolines - 1) 
							instVarIndex: instVarIndex ) ] ].
	ceStoreCheckTrampoline := cogit
									genTrampolineFor: #remember:
									called: 'ceStoreCheckTrampoline'
									arg: ReceiverResultReg
									regsToSave: (cogit callerSavedRegMask bitClear: (cogit registerMaskFor: ReceiverResultReg))
									result: cogit returnRegForStoreCheck.
	ceStoreCheckContextReceiverTrampoline := self genStoreCheckContextReceiverTrampoline.
	ceScheduleScavengeTrampoline := cogit
											genTrampolineFor: #ceScheduleScavenge
											called: 'ceScheduleScavengeTrampoline'
											regsToSave: cogit callerSavedRegMask.
	ceSmallActiveContextInMethodTrampoline := self genActiveContextTrampolineLarge: false inBlock: false called: 'ceSmallMethodContext'.
	ceSmallActiveContextInBlockTrampoline := self genActiveContextTrampolineLarge: false inBlock: true called: 'ceSmallBlockContext'.
	ceLargeActiveContextInMethodTrampoline := self genActiveContextTrampolineLarge: true inBlock: false called: 'ceLargeMethodContext'.
	ceLargeActiveContextInBlockTrampoline := self genActiveContextTrampolineLarge: true inBlock: true called: 'ceLargeBlockContext'