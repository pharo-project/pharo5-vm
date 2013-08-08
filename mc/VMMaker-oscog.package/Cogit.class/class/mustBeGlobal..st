translation
mustBeGlobal: var
	"Answer if a variable must be global and exported.  Used for inst vars that are accessed from VM
	 support code.  include cePositive32BitIntegerTrampoline as a hack to prevent it being inlined (it is
	 only used outside of Cogit by the object representation).  Include labelCounter as a hack to stop it
	 being inlined into genLabel, and CFramePointer CStackPointer as a hack to get them declared at all."
	^#('ceBaseFrameReturnTrampoline' 'ceCaptureCStackPointers' 'ceCheckForInterruptTrampoline'
		'ceEnterCogCodePopReceiverReg' 'realCEEnterCogCodePopReceiverReg'
		'ceEnterCogCodePopReceiverAndClassRegs' 'realCEEnterCogCodePopReceiverAndClassRegs'
		'ceReturnToInterpreterTrampoline' 'ceCannotResumeTrampoline'
		'cePositive32BitIntegerTrampoline' 'ceFlushICache' 'ceTryLockVMOwner' 'ceUnlockVMOwner'
		'cmEntryOffset' 'cmNoCheckEntryOffset' 'cmDynSuperEntryOffset'
		'blockNoContextSwitchOffset' 'breakPC'
		'labelCounter' 'CFramePointer' 'CStackPointer' 'cFramePointerInUse' 'ceGetSP'
		'traceFlags' 'traceStores' 'debugPrimCallStackOffset')
			includes: var