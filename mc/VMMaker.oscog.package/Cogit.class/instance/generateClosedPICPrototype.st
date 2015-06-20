initialization
generateClosedPICPrototype
	"Generate the prototype ClosedPIC to determine how much space as full PIC takes.
	 When we first allocate a closed PIC it only has one or two cases and we want to grow it.
	 So we have to determine how big a full one is before hand."
	| cPIC |
	<var: 'cPIC' type: #'CogMethod *'>
	numPICCases := 6.
	"stack allocate the various collections so that they
	 are effectively garbage collected on return."
	self allocateOpcodes: numPICCases * 9 bytecodes: 0.
	methodLabel address: methodZoneBase; dependent: nil. "for pc-relative MoveCw: cPIC R: ClassReg"
	self compileClosedPICPrototype.
	self computeMaximumSizes.
	cPIC := (self cCoerceSimple: methodZoneBase to: #'CogMethod *').
	closedPICSize := (self sizeof: CogMethod) + (self generateInstructionsAt: methodZoneBase + (self sizeof: CogMethod)).
	self outputInstructionsAt: methodZoneBase + (self sizeof: CogMethod).
	firstCPICCaseOffset := endCPICCase0 address - methodZoneBase.
	cPICCaseSize := endCPICCase1 address - endCPICCase0 address.
	cPICEndSize := closedPICSize - (numPICCases - 1 * cPICCaseSize + firstCPICCaseOffset).
	closedPICSize := methodZone roundUpLength: closedPICSize.
	self assert: picInterpretAbort address = (methodLabel address + self picInterpretAbortOffset).
	self assert: (self expectedClosedPICPrototype: cPIC) = 0
	"self cCode: ''
		inSmalltalk:
			[self disassembleFrom: methodZoneBase + (self sizeof: CogMethod) to: methodZoneBase + closedPICSize - 1.
			 self halt]"