initialization
generateOpenPICPrototype
	"Generate the prototype ClosedPIC to determine how much space as full PIC takes.
	 When we first allocate a closed PIC it only has one or two cases and we want to grow it.
	 So we have to determine how big a full one is before hand."
	| headerSize codeSize mapSize |
	"stack allocate the various collections so that they
	 are effectively garbage collected on return."
	self allocateOpcodes: 100 bytecodes: 0.
	"Ned a real selector here so that the map accomodates the annotations for the selector."
	self compileOpenPIC: (coInterpreter specialSelector: 0) numArgs: self numRegArgs.
	self computeMaximumSizes.
	headerSize := self sizeof: CogMethod.
	methodLabel concretizeAt: methodZoneBase.
	codeSize := self generateInstructionsAt: methodZoneBase + headerSize.
	mapSize := self generateMapAt: 0 start: methodZoneBase + cmNoCheckEntryOffset.
	openPICSize := (methodZone roundUpLength: headerSize + codeSize) + (methodZone roundUpLength: mapSize).
	"self cCode: ''
		inSmalltalk:
			[| end |
			 end := self outputInstructionsAt: methodZoneBase + headerSize.
			 self disassembleFrom: methodZoneBase + headerSize to: end - 1.
			 self halt]"