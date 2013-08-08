initialization
generateEnilopmarts
	"Enilopmarts transfer control from C into machine code (backwards trampolines)."
	self cppIf: Debug
		ifTrue:
			[realCEEnterCogCodePopReceiverReg :=
				self genEnilopmartFor: ReceiverResultReg
					called: 'realCEEnterCogCodePopReceiverReg'.
			 ceEnterCogCodePopReceiverReg := #enterCogCodePopReceiver.
			 realCEEnterCogCodePopReceiverAndClassRegs :=
				self genEnilopmartFor: ReceiverResultReg
					and: ClassReg
					called: 'realCEEnterCogCodePopReceiverAndClassRegs'.
			 ceEnterCogCodePopReceiverAndClassRegs := #enterCogCodePopReceiverAndClassRegs]
		ifFalse:
			[ceEnterCogCodePopReceiverReg := self genEnilopmartFor: ReceiverResultReg
				called: 'ceEnterCogCodePopReceiverReg'.
			 ceEnterCogCodePopReceiverAndClassRegs :=
				self genEnilopmartFor: ReceiverResultReg
					and: ClassReg
					called: 'ceEnterCogCodePopReceiverAndClassRegs'].

	self genPrimReturnEnterCogCodeEnilopmart: false.
	cePrimReturnEnterCogCode := methodZoneBase.
	self outputInstructionsForGeneratedRuntimeAt: cePrimReturnEnterCogCode.
	self recordGeneratedRunTime: 'cePrimReturnEnterCogCode' address: cePrimReturnEnterCogCode.

	self genPrimReturnEnterCogCodeEnilopmart: true.
	cePrimReturnEnterCogCodeProfiling := methodZoneBase.
	self outputInstructionsForGeneratedRuntimeAt: cePrimReturnEnterCogCodeProfiling.
	self recordGeneratedRunTime: 'cePrimReturnEnterCogCodeProfiling' address: cePrimReturnEnterCogCodeProfiling