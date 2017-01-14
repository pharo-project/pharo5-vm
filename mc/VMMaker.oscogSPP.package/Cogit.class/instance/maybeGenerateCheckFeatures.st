initialization
maybeGenerateCheckFeatures
	| startAddress |
	<inline: true>
	backEnd numCheckFeaturesOpcodes > 0 ifTrue:
		[self allocateOpcodes: backEnd numCheckFeaturesOpcodes bytecodes: 0.
		 startAddress := methodZoneBase.
		 backEnd generateCheckFeatures.
		 self outputInstructionsForGeneratedRuntimeAt: startAddress.
		 self recordGeneratedRunTime: 'ceCheckFeaturesFunction' address: startAddress.
		 ceCheckFeaturesFunction := self cCoerceSimple: startAddress to: #'usqIntptr_t (*)(void)']