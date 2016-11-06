initialization
genGetLeafCallStackPointer
	"Generate a routine that answers the stack pointer immedately
	 after a leaf call, used for checking stack pointer alignment."
	| startAddress |
	<inline: false>
	self allocateOpcodes: 4 bytecodes: 0.
	startAddress := methodZoneBase.
	self
		MoveR: FPReg R: backEnd cResultRegister;
		RetN: 0.
	self outputInstructionsForGeneratedRuntimeAt: startAddress.
	self recordGeneratedRunTime: 'ceGetFP' address: startAddress.
	ceGetFP := self cCoerceSimple: startAddress to: #'usqIntptr_t (*)(void)'.
	startAddress := methodZoneBase.
	self zeroOpcodeIndex.
	self MoveR: SPReg R: backEnd cResultRegister.
	backEnd leafCallStackPointerDelta ~= 0 ifTrue:
		[self AddCq: backEnd leafCallStackPointerDelta R: backEnd cResultRegister].
	self RetN: 0.
	self outputInstructionsForGeneratedRuntimeAt: startAddress.
	self recordGeneratedRunTime: 'ceGetSP' address: startAddress.
	ceGetSP := self cCoerceSimple: startAddress to: #'usqIntptr_t (*)(void)'