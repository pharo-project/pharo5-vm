translation
mustBeGlobal: var
	"Answer if a variable must be global and exported.  Used for inst vars that are accessed from VM
	 support code.  include cePositive32BitIntegerTrampoline as a hack to prevent it being inlined (it is
	 only used outside of Cogit by the object representation).  Include CFramePointer CStackPointer as
	 a hack to get them declared at all."
	^#(	'ceBaseFrameReturnTrampoline' #ceCaptureCStackPointers 'ceCheckForInterruptTrampoline'
		ceEnterCogCodePopReceiverReg realCEEnterCogCodePopReceiverReg
		ceCallCogCodePopReceiverReg realCECallCogCodePopReceiverReg
		ceCallCogCodePopReceiverAndClassRegs realCECallCogCodePopReceiverAndClassRegs
		'ceReturnToInterpreterTrampoline' 'ceCannotResumeTrampoline'
		ceTryLockVMOwner ceUnlockVMOwner
		'cmEntryOffset' 'cmNoCheckEntryOffset' 'cmDynSuperEntryOffset' 'cmSelfSendEntryOffset'
		'missOffset' 'cbEntryOffset' 'cbNoSwitchEntryOffset' 'blockNoContextSwitchOffset' breakPC
		CFramePointer CStackPointer 'cFramePointerInUse' ceGetFP ceGetSP
		traceFlags 'traceStores' debugPrimCallStackOffset)
			includes: var