initialization
generateEnilopmarts
	"Enilopmarts transfer control from C into machine code (backwards trampolines)."
	self cppIf: Debug
		ifTrue:
			[realCEEnterCogCodePopReceiverReg :=
				self genEnilopmartFor: ReceiverResultReg
					forCall: false
					called: 'realCEEnterCogCodePopReceiverReg'.
			 ceEnterCogCodePopReceiverReg := #enterCogCodePopReceiver.
			 realCECallCogCodePopReceiverReg :=
				self genEnilopmartFor: ReceiverResultReg
					forCall: true
					called: 'realCEEnterCogCodePopReceiverReg'.
			 ceCallCogCodePopReceiverReg := #callCogCodePopReceiver.
			 realCECallCogCodePopReceiverAndClassRegs :=
				self genEnilopmartFor: ReceiverResultReg
					and: ClassReg
					forCall: true
					called: 'realCECallCogCodePopReceiverAndClassRegs'.
			 ceCallCogCodePopReceiverAndClassRegs := #callCogCodePopReceiverAndClassRegs]
		ifFalse:
			[ceEnterCogCodePopReceiverReg := self genEnilopmartFor: ReceiverResultReg
														forCall: false
														called: 'ceEnterCogCodePopReceiverReg'.
			 ceCallCogCodePopReceiverReg := self genEnilopmartFor: ReceiverResultReg
													forCall: true
													called: 'ceCallCogCodePopReceiverReg'.
			 ceCallCogCodePopReceiverAndClassRegs :=
				self genEnilopmartFor: ReceiverResultReg
					and: ClassReg
					forCall: true
					called: 'ceCallCogCodePopReceiverAndClassRegs'].

	self genPrimReturnEnterCogCodeEnilopmart: false.
	cePrimReturnEnterCogCode := methodZoneBase.
	self outputInstructionsForGeneratedRuntimeAt: cePrimReturnEnterCogCode.
	self recordGeneratedRunTime: 'cePrimReturnEnterCogCode' address: cePrimReturnEnterCogCode.

	self genPrimReturnEnterCogCodeEnilopmart: true.
	cePrimReturnEnterCogCodeProfiling := methodZoneBase.
	self outputInstructionsForGeneratedRuntimeAt: cePrimReturnEnterCogCodeProfiling.
	self recordGeneratedRunTime: 'cePrimReturnEnterCogCodeProfiling' address: cePrimReturnEnterCogCodeProfiling