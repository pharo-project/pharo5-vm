initialization
genGetLeafCallStackPointer
	"Generate a routine that answers the stack pointer immedately
	 after a leaf call, used for checking stack pointer alignment."
	| startAddress |
	<inline: false>
	self allocateOpcodes: 32 bytecodes: 0.
	startAddress := methodZoneBase.
	backEnd genGetLeafCallStackPointerFunction.
	self outputInstructionsForGeneratedRuntimeAt: startAddress.
	self recordGeneratedRunTime: 'ceGetSP' address: startAddress.
	ceGetSP := self cCoerceSimple: startAddress to: #'unsigned long (*)(void)'