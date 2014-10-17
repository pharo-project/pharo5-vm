initialization
generateEnilopmarts
	"Enilopmarts transfer control from C into machine code (backwards trampolines)."
	self cppIf: Debug
		ifTrue:
			[realCEEnterCogCodePopReceiverReg :=
				self genEnilopmartFor: ReceiverResultReg
					called: 'realCEEnterCogCodePopReceiverReg'.
			 ceEnterCogCodePopReceiverReg := #enterCogCodePopReceiver.
			 realCECallCogCodePopReceiverReg :=
				self genCallEnilopmartFor: ReceiverResultReg
					called: 'realCEEnterCogCodePopReceiverReg'.
			 ceCallCogCodePopReceiverReg := #callCogCodePopReceiver.
			 realCECallCogCodePopReceiverAndClassRegs :=
				self genCallEnilopmartFor: ReceiverResultReg
					and: ClassReg
					called: 'realCECallCogCodePopReceiverAndClassRegs'.
			 ceCallCogCodePopReceiverAndClassRegs := #callCogCodePopReceiverAndClassRegs]
		ifFalse:
			[ceEnterCogCodePopReceiverReg := self genEnilopmartFor: ReceiverResultReg
				called: 'ceEnterCogCodePopReceiverReg'.
			 ceCallCogCodePopReceiverReg := self genCallEnilopmartFor: ReceiverResultReg
				called: 'ceCallCogCodePopReceiverReg'.
			 ceCallCogCodePopReceiverAndClassRegs :=
				self genCallEnilopmartFor: ReceiverResultReg
					and: ClassReg
					called: 'ceCallCogCodePopReceiverAndClassRegs'].

	self genPrimReturnEnterCogCodeEnilopmart: false.
	cePrimReturnEnterCogCode := methodZoneBase.
	self outputInstructionsForGeneratedRuntimeAt: cePrimReturnEnterCogCode.
	self recordGeneratedRunTime: 'cePrimReturnEnterCogCode' address: cePrimReturnEnterCogCode.

	self genPrimReturnEnterCogCodeEnilopmart: true.
	cePrimReturnEnterCogCodeProfiling := methodZoneBase.
	self outputInstructionsForGeneratedRuntimeAt: cePrimReturnEnterCogCodeProfiling.
	self recordGeneratedRunTime: 'cePrimReturnEnterCogCodeProfiling' address: cePrimReturnEnterCogCodeProfiling