documentation
runtime
	"Generated machine code makes use of a number of run-time routines for support, for executing certain primitives,
	 and for event handling.  These run-time entry points all begin with ce, for ``code entry''.  They are called from
	 trampolines whose job it is to a) switch from the Smalltalk stack to the C stack (because run-time routines are C
	 code in the CoInterpreter or Cogit and run on the C stack, whereas machine code runs on the Smalltalk stack), and
	 b) to marshall the register parameters that trampol,ines take into what ever the platform's ABI requires.
	 See the method trampolines for more info on trampoilines.

	 Here's a doit to collect the signatures of the current run-time routines
 
		(((CoInterpreter selectors select: [:ea| (ea beginsWith: 'ce') and: [ea third isUppercase]]) ,
		(SistaStackToRegisterMappingCogit allSelectors select: [:ea| (ea beginsWith: 'ce') and: [ea third isUppercase]]) asArray) sort collect:
			[:s| | m |
			m := CoInterpreter compiledMethodAt: s ifAbsent: [(SistaStackToRegisterMappingCogit whichClassIncludesSelector: s) >> s].
			s numArgs = 0
				ifTrue: [s asString]
				ifFalse:
					[(String streamContents:
						[:str|
						s keywords with: (CoInterpreter newParser parseParameterNames: m getSource) do:
							[:k :p| str nextPutAll: k; space; nextPutAll: p; nextPutAll: ' (Reg) ']]) allButLast]])


	Run-time:
		ceActivateFailingPrimitiveMethod: aPrimitiveMethod (SendNumArgsReg)
		ceActiveContext => ReceiverResultReg
		ceBaseFrameReturn: returnValue (ReceiverResultReg)
		ceBaseFrameReturnPC
		ceCPICMiss: cPIC (ClassReg) receiver: receiver (ReceiverResultReg)
		ceCall0ArgsPIC
		ceCall1ArgsPIC
		ceCall2ArgsPIC
		ceCannotResume
		ceCannotResumePC
		ceCaptureCStackPointers
		ceCheckFeatures
		ceCheckForAndFollowForwardedPrimitiveState
		ceCheckForInterrupts
		ceCheckProfileTick
		ceClosureCopyDescriptor: descriptor (SendNumArgsReg) => ReceiverResultReg
		ceContext: maybeContext (ReceiverResultReg) instVar: slotIndex (SendNumArgsReg) => ReceiverResultReg
		ceContext: maybeMarriedContext (ReceiverResultReg) instVar: slotIndex (SendNumArgsReg) value: anOop (ClassReg) => ReceiverResultReg
		ceCounterTripped: condition (TempReg)
		ceDynamicSuperSend: cacheAddress (SendNumArgsReg) receiver: methodReceiver (ReceiverResultReg)
		ceEnclosingObjectAt: level (SendNumArgsReg) => ReceiverResultReg
		ceImplicitReceiverSend: cacheAddress (SendNumArgsReg) receiver: methodReceiver (ReceiverResultReg)
		ceInterpretMethodFromPIC: aMethodObj (SendNumArgsReg) receiver: rcvr (ReceiverResultReg)
		ceMNUFromPICMNUMethod: aMethodObj (SendNumArgsReg) receiver: rcvr (ReceiverResultReg)
		ceNewArraySlotSize: slotSize (SendNumArgsReg) => ReceiverResultReg
		ceNonLocalReturn: returnValue (ReceiverResultReg)
		ceOuterSend: cacheAddress (SendNumArgsReg) receiver: methodReceiver (ReceiverResultReg)
		ceReturnToInterpreter: anOop (ReceiverResultReg)
		ceReturnToInterpreterPC
		ceSICMiss: receiver (ReceiverResultReg)
		ceScheduleScavenge
		ceSelfSend: cacheAddress (SendNumArgsReg) receiver: methodReceiver (ReceiverResultReg)
		ceSend: selector (ClassReg) above: startAssociationArg (TempReg) to: rcvr (ReceiverResultReg) numArgs: numArgs (n)
		ceSend: selector (ClassReg) super: superNormalBar (n) to: rcvr (ReceiverResultReg) numArgs: numArgs (n)
		ceSendFromInLineCacheMiss: cogMethodOrPIC (SendNumArgsReg)
		ceSendMustBeBoolean: anObject (TempReg)
		ceSistaTrap
		ceStackOverflow: contextSwitchIfNotNil (SendNumArgsReg)
		ceTraceBlockActivation
		ceTraceLinkedSend: theReceiver (ReceiverResultReg)
		ceTraceStoreOf: aValue (ClassReg) into: anObject (ReceiverResultReg)
		positive32BitIntegerFor: integerValue (ReceiverResultReg) => TempReg

	Enilopmarts:
		ceCallCogCodePopReceiverAndClassRegs
		ceCallCogCodePopReceiverArg0Regs
		ceCallCogCodePopReceiverArg1Arg0Regs
		ceCallCogCodePopReceiverReg
		ceEnterCogCodePopReceiverReg

	Simulation only
		ceShortCutTraceBlockActivation: aProcessorSimulationTrap
		ceShortCutTraceLinkedSend: aProcessorSimulationTrap
		ceShortCutTraceStore: aProcessorSimulationTrap

	Misnamed:
		ceSendAbort:to:numArgs: not a code entry.  Used by ceCannotResume, ceSendMustBeBoolean et al to execute their sends"