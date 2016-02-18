initialization
generateObjectRepresentationTrampolines
	"Do the store check.  Answer the argument for the benefit of the code generator;
	 ReceiverResultReg may be caller-saved and hence smashed by this call.  Answering
	 it allows the code generator to reload ReceiverResultReg cheaply.
	 In Spur the only thing we leave to the run-time is adding the receiver to the
	 remembered set and setting its isRemembered bit."
	self 
		cppIf: IMMUTABILITY
		ifTrue: "c.f. genImmutableCheck:slotIndex:sourceReg:scratchReg:popBoolean:needRestoreRcvr:"
			[ceCannotAssignToWithIndexTrampoline := cogit
															genTrampolineFor: #ceCannotAssignTo:withIndex:valueToAssign:
															called: 'ceCannotAssignToWithIndexTrampoline'
															arg: ReceiverResultReg 
															arg: TempReg
															arg: ClassReg].
	ceStoreCheckTrampoline := cogit
									genTrampolineFor: #remember:
									called: 'ceStoreCheckTrampoline'
									arg: ReceiverResultReg
									result: cogit returnRegForStoreCheck.
	ceStoreCheckContextReceiverTrampoline := self genStoreCheckContextReceiverTrampoline.
	ceScheduleScavengeTrampoline := cogit
											genSafeTrampolineFor: #ceScheduleScavenge
											called: 'ceScheduleScavengeTrampoline'.
	ceSmallActiveContextInMethodTrampoline := self genActiveContextTrampolineLarge: false inBlock: false called: 'ceSmallMethodContext'.
	ceSmallActiveContextInBlockTrampoline := self genActiveContextTrampolineLarge: false inBlock: true called: 'ceSmallBlockContext'.
	ceLargeActiveContextInMethodTrampoline := self genActiveContextTrampolineLarge: true inBlock: false called: 'ceLargeMethodContext'.
	ceLargeActiveContextInBlockTrampoline := self genActiveContextTrampolineLarge: true inBlock: true called: 'ceLargeBlockContext'