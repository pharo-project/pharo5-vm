initialization
generateClosedPICPrototype
	"Generate the prototype ClosedPIC to determine how much space as full PIC takes.
	 When we first allocate a closed PIC it only has one or two cases and we want to grow it.
	 So we have to determine how big a full one is before hand."
	| cPIC endAddress |
	<var: 'cPIC' type: #'CogMethod *'>
	"stack allocate the various collections so that they
	 are effectively garbage collected on return."
	self allocateOpcodes: MaxCPICCases * 9 bytecodes: 0.
	methodLabel address: methodZoneBase; dependent: nil. "for pc-relative MoveCw: cPIC R: ClassReg"
	self compileClosedPICPrototype.
	self computeMaximumSizes.
	cPIC := (self cCoerceSimple: methodZoneBase to: #'CogMethod *').
	closedPICSize := (self sizeof: CogMethod) + (self generateInstructionsAt: methodZoneBase + (self sizeof: CogMethod)).
	endAddress := self outputInstructionsAt: methodZoneBase + (self sizeof: CogMethod).
	self assert: methodZoneBase + closedPICSize = endAddress.
	firstCPICCaseOffset := endCPICCase0 address - methodZoneBase.
	cPICEndOfCodeOffset := cPICEndOfCodeLabel address - methodZoneBase.
	cPICCaseSize := endCPICCase1 address - endCPICCase0 address.
	cPICEndSize := closedPICSize - (MaxCPICCases - 1 * cPICCaseSize + firstCPICCaseOffset).
	closedPICSize := methodZone roundUpLength: closedPICSize.
	self assert: picInterpretAbort address = (methodLabel address + self picInterpretAbortOffset).
	self assert: (self expectedClosedPICPrototype: cPIC) = 0.
	
	"tpr this is a little tiresome but after any assert checking we need to 0 out the case0 objRef rather than leaving 16r5EAF00D lying around"

	backEnd storeLiteral: 0 beforeFollowingAddress: endCPICCase0 address - backEnd jumpLongByteSize.
	
	"update the methodZoneBase so we keep the prototype aruond for later use"
	methodZoneBase := self alignUptoRoutineBoundary: endAddress.
	cPICPrototype := cPIC.
	"self cCode: ''
		inSmalltalk:
			[self disassembleFrom: cPIC + (self sizeof: CogMethod) to: cPIC + closedPICSize - 1.
			 self halt]"