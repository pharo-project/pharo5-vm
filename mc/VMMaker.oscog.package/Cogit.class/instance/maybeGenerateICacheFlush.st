initialization
maybeGenerateICacheFlush
	| startAddress |
	<inline: false>
	backEnd numICacheFlushOpcodes = 0 ifTrue:
		[^nil].
	self allocateOpcodes: backEnd numICacheFlushOpcodes bytecodes: 0.
	initialPC := 0.
	endPC := numAbstractOpcodes - 1.
	startAddress := methodZoneBase.
	backEnd generateICacheFlush.
	self outputInstructionsForGeneratedRuntimeAt: startAddress.
	self recordGeneratedRunTime: 'ceFlushICache' address: startAddress.
	ceFlushICache := self cCoerceSimple: startAddress to: #'void (*)(unsigned long,unsigned long)'