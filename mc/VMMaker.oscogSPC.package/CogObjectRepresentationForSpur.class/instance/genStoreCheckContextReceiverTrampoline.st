initialization
genStoreCheckContextReceiverTrampoline
	"Create a trampoline to store-check the update of the receiver in a closure's
	 outerContext in compileBlockFrameBuild:."
	| startAddress |
	startAddress := cogit methodZoneBase.
	cogit zeroOpcodeIndex.
	self genStoreCheckReceiverReg: ReceiverResultReg valueReg: Arg0Reg scratchReg: TempReg inFrame: false.
	cogit RetN: 0.
	cogit outputInstructionsForGeneratedRuntimeAt: startAddress.
	cogit recordGeneratedRunTime: 'ceStoreCheckContextReceiver' address: startAddress.
	cogit recordRunTimeObjectReferences.
	^startAddress