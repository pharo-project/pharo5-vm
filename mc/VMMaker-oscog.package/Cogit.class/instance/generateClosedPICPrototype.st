initialization
generateClosedPICPrototype
	"Generate the prototype ClosedPIC to determine how much space as full PIC takes.
	 When we first allocate a closed PIC it only has one or two cases and we want to grow it.
	 So we have to determine how big a full one is before hand."
	| headerSize |
	numPICCases := 6.
	"stack allocate the various collections so that they
	 are effectively garbage collected on return."
	self allocateOpcodes: numPICCases * 7 bytecodes: 0.
	self compileClosedPICPrototype.
	self computeMaximumSizes.
	headerSize := self sizeof: CogMethod.
	closedPICSize := headerSize + (self generateInstructionsAt: methodZoneBase + headerSize).
	firstCPICCaseOffset := endCPICCase0 address - methodZoneBase.
	cPICCaseSize := endCPICCase1 address - endCPICCase0 address.
	cPICEndSize := closedPICSize - (numPICCases - 1 * cPICCaseSize + firstCPICCaseOffset).
	closedPICSize := methodZone roundUpLength: closedPICSize
	"self cCode: ''
		inSmalltalk:
			[| end |
			 end := self outputInstructionsAt: methodZoneBase + headerSize.
			 self disassembleFrom: methodZoneBase + headerSize to: end - 1.
			 self halt]"