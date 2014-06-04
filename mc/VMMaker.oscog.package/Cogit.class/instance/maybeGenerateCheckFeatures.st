initialization
maybeGenerateCheckFeatures
	| startAddress |
	<inline: false>
	backEnd numCheckFeaturesOpcodes = 0 ifTrue:
		[^nil].
	self allocateOpcodes: backEnd numCheckFeaturesOpcodes bytecodes: 0.
	initialPC := 0.
	endPC := numAbstractOpcodes - 1.
	startAddress := methodZoneBase.
	backEnd generateCheckFeatures.
	self outputInstructionsForGeneratedRuntimeAt: startAddress.
	self recordGeneratedRunTime: 'ceCheckFeaturesFunction' address: startAddress.
	ceCheckFeaturesFunction := self cCoerceSimple: startAddress to: #'unsigned long (*)(void)'