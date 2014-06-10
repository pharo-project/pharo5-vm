in-line cacheing
compileOpenPIC: selector numArgs: numArgs
	"Compile the code for an open PIC.  Perform a probe of the first-level method
	 lookup cache followed by a call of ceSendFromInLineCacheMiss: if the probe fails.
	 Override to push the register args when calling ceSendFromInLineCacheMiss:"
	| jumpSelectorMiss jumpClassMiss itsAHit jumpBCMethod routine |
	<var: #jumpSelectorMiss type: #'AbstractInstruction *'>
	<var: #jumpClassMiss type: #'AbstractInstruction *'>
	<var: #itsAHit type: #'AbstractInstruction *'>
	<var: #jumpBCMethod type: #'AbstractInstruction *'>
	self compilePICProlog: numArgs.
	self cppIf: NewspeakVM ifTrue:
		[self Nop. "1st nop differentiates dynSuperEntry from no-check entry if using nextMethod"
		 dynSuperEntry := self Nop].
	entry := objectRepresentation genGetClassTagOf: ReceiverResultReg into: ClassReg scratchReg: TempReg.

	"Do first of three probes.  See CoInterpreter>>lookupInMethodCacheSel:classTag:"
	self flag: #lookupInMethodCacheSel:classTag:. "so this method shows up as a sender of lookupInMethodCacheSel:class:"
	self MoveR: ClassReg R: SendNumArgsReg.
	self annotate: (self XorCw: selector R: ClassReg) objRef: selector.
	self LogicalShiftLeftCq: ShiftForWord R: ClassReg.
	self AndCq: MethodCacheMask << ShiftForWord R: ClassReg.
	self MoveMw: coInterpreter methodCacheAddress asUnsignedInteger + (MethodCacheSelector << ShiftForWord)
		r: ClassReg
		R: TempReg.
	self annotate: (self CmpCw: selector R: TempReg) objRef: selector.
	jumpSelectorMiss := self JumpNonZero: 0.
	self MoveMw: coInterpreter methodCacheAddress asUnsignedInteger + (MethodCacheClass << ShiftForWord)
		r: ClassReg
		R: TempReg.
	self CmpR: SendNumArgsReg R: TempReg.
	jumpClassMiss := self JumpNonZero: 0.

	itsAHit := self Label.
	"Fetch the method.  The interpret trampoline requires the bytecoded method in SendNumArgsReg"
	self MoveMw: coInterpreter methodCacheAddress asUnsignedInteger + (MethodCacheMethod << ShiftForWord)
		r: ClassReg
		R: SendNumArgsReg.
	"If the method is compiled jump to its unchecked entry-point, otherwise interpret it."
	objectRepresentation
		genLoadSlot: HeaderIndex sourceReg: SendNumArgsReg destReg: TempReg.
	self MoveR: TempReg R: ClassReg.
	jumpBCMethod := objectRepresentation genJumpSmallIntegerInScratchReg: TempReg.
	jumpBCMethod jmpTarget: interpretLabel.
	self AddCq: cmNoCheckEntryOffset R: ClassReg.
	self JumpR: ClassReg.

	"First probe missed.  Do second of three probes.  Shift hash right one and retry."
	jumpSelectorMiss jmpTarget: (jumpClassMiss jmpTarget: self Label).
	self MoveR: SendNumArgsReg R: ClassReg.
	self annotate: (self XorCw: selector R: ClassReg) objRef: selector.
	self LogicalShiftLeftCq: ShiftForWord - 1 R: ClassReg.
	self AndCq: MethodCacheMask << ShiftForWord R: ClassReg.
	self MoveMw: coInterpreter methodCacheAddress asUnsignedInteger + (MethodCacheSelector << ShiftForWord)
		r: ClassReg
		R: TempReg.
	self annotate: (self CmpCw: selector R: TempReg) objRef: selector.
	jumpSelectorMiss := self JumpNonZero: 0.
	self MoveMw: coInterpreter methodCacheAddress asUnsignedInteger + (MethodCacheClass << ShiftForWord)
		r: ClassReg
		R: TempReg.
	self CmpR: SendNumArgsReg R: TempReg.
	self JumpZero: itsAHit.

	"Second probe missed.  Do last probe.  Shift hash right two and retry."
	jumpSelectorMiss jmpTarget: self Label.
	self MoveR: SendNumArgsReg R: ClassReg.
	self annotate: (self XorCw: selector R: ClassReg) objRef: selector.
	ShiftForWord > 2 ifTrue:
		[self LogicalShiftLeftCq: ShiftForWord - 1 R: ClassReg].
	self AndCq: MethodCacheMask << ShiftForWord R: ClassReg.
	self MoveMw: coInterpreter methodCacheAddress asUnsignedInteger + (MethodCacheSelector << ShiftForWord)
		r: ClassReg
		R: TempReg.
	self annotate: (self CmpCw: selector R: TempReg) objRef: selector.
	jumpSelectorMiss := self JumpNonZero: 0.
	self MoveMw: coInterpreter methodCacheAddress asUnsignedInteger + (MethodCacheClass << ShiftForWord)
		r: ClassReg
		R: TempReg.
	self CmpR: SendNumArgsReg R: TempReg.
	self JumpZero: itsAHit.

	"Last probe missed.  Call ceSendFromInLineCacheMiss: to do the full lookup."
	jumpSelectorMiss jmpTarget: self Label.
	backEnd genPushRegisterArgsForNumArgs: numArgs.
	self genSmalltalkToCStackSwitch.
	methodLabel addDependent: (self annotateAbsolutePCRef: (self MoveCw: methodLabel asInteger R: SendNumArgsReg)).
	cStackAlignment > BytesPerWord ifTrue:
		[backEnd
			genAlignCStackSavingRegisters: false
			numArgs: 1
			wordAlignment: cStackAlignment / BytesPerWord].
	backEnd genPassReg: SendNumArgsReg asArgument: 0.
	routine := self cCode: '(sqInt)ceSendFromInLineCacheMiss'
					inSmalltalk: [self simulatedAddressFor: #ceSendFromInLineCacheMiss:].
	self annotateCall: (self Call: routine)
	"Note that this call does not return."