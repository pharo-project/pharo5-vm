initialization
generateOpenPICPrototype
	"Generate the prototype ClosedPIC to determine how much space as full PIC takes.
	 When we first allocate a closed PIC it only has one or two cases and we want to grow it.
	 So we have to determine how big a full one is before hand."
	| codeSize mapSize |
	"stack allocate the various collections so that they
	 are effectively garbage collected on return."
	self allocateOpcodes: 100 bytecodes: 0.
	methodLabel
		address: methodZoneBase;
		dependent: nil.
	"Need a real selector here so that the map accomodates the annotations for the selector.
	 Use self numRegArgs to generate the longest possible code sequence due to
	 genPushRegisterArgsForNumArgs:"
	self compileOpenPIC: (coInterpreter specialSelector: 0) numArgs: self numRegArgs.
	self computeMaximumSizes.
	methodLabel concretizeAt: methodZoneBase.
	codeSize := self generateInstructionsAt: methodZoneBase + (self sizeof: CogMethod).
	mapSize := self generateMapAt: nil start: methodZoneBase + cmNoCheckEntryOffset.
	openPICSize := (methodZone roundUpLength: (self sizeof: CogMethod) + codeSize) + (methodZone roundUpLength: mapSize).
	"self cCode: ''
		inSmalltalk:
			[| end |
			 end := self outputInstructionsAt: methodZoneBase + headerSize.
			 self disassembleFrom: methodZoneBase + (self sizeof: CogMethod) to: end - 1.
			 self halt]"