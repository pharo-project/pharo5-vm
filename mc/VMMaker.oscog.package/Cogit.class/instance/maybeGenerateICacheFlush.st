initialization
maybeGenerateICacheFlush
	| startAddress |
	<inline: true>
	backEnd numICacheFlushOpcodes > 0 ifTrue:
		[self allocateOpcodes: backEnd numICacheFlushOpcodes bytecodes: 0.
		 startAddress := methodZoneBase.
		 backEnd generateICacheFlush.
		 self outputInstructionsForGeneratedRuntimeAt: startAddress.
		 self recordGeneratedRunTime: 'ceFlushICache' address: startAddress.
		 ceFlushICache := self cCoerceSimple: startAddress to: #'void (*)(usqIntptr_t,usqIntptr_t)']