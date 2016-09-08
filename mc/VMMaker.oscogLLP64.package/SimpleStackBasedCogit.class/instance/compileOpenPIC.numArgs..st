in-line cacheing
compileOpenPIC: selector numArgs: numArgs
	"Compile the code for an open PIC.  Perform a probe of the first-level method
	 lookup cache followed by a call of ceSendFromInLineCacheMiss: if the probe fails."
	| cacheBaseReg jumpSelectorMiss jumpClassMiss itsAHit jumpBCMethod |
	<var: #jumpSelectorMiss type: #'AbstractInstruction *'>
	<var: #jumpClassMiss type: #'AbstractInstruction *'>
	<var: #itsAHit type: #'AbstractInstruction *'>
	<var: #jumpBCMethod type: #'AbstractInstruction *'>
	self preenMethodLabel.
	self compilePICAbort: numArgs.
	entry := objectRepresentation genGetClassTagOf: ReceiverResultReg into: SendNumArgsReg scratchReg: TempReg.

	self flag: #lookupInMethodCacheSel:classTag:. "so this method shows up as a sender of lookupInMethodCacheSel:class:"

	cacheBaseReg := NoReg.
	(backEnd isWithinMwOffsetRange: coInterpreter methodCacheAddress) ifFalse:
		[self MoveCq: coInterpreter methodCacheAddress R: (cacheBaseReg := Extra0Reg)].

	"Do first of three probes.  See CoInterpreter>>lookupInMethodCacheSel:classTag:"
	jumpSelectorMiss := self compileOpenPICMethodCacheProbeFor: selector withShift: 0 baseRegOrNone: cacheBaseReg.
	jumpClassMiss := self JumpNonZero: 0.

	"Fetch the method.  The interpret trampoline requires the bytecoded method in SendNumArgsReg"
	itsAHit := self MoveMw: (cacheBaseReg = NoReg
								ifTrue: [coInterpreter methodCacheAddress asUnsignedInteger + (MethodCacheMethod << objectMemory shiftForWord)]
								ifFalse: [MethodCacheMethod << objectMemory shiftForWord])
					r: ClassReg
					R: SendNumArgsReg.
			.
	"If the method is compiled jump to its unchecked entry-point, otherwise interpret it."
	objectRepresentation genLoadSlot: HeaderIndex sourceReg: SendNumArgsReg destReg: ClassReg.
	jumpBCMethod := objectRepresentation genJumpImmediate: ClassReg.
	jumpBCMethod jmpTarget: picInterpretAbort.
	self AddCq: cmNoCheckEntryOffset R: ClassReg.
	self JumpR: ClassReg.

	"First probe missed.  Do second of three probes.  Shift hash right one and retry."
	jumpSelectorMiss jmpTarget: (jumpClassMiss jmpTarget: self Label).
	jumpSelectorMiss := self compileOpenPICMethodCacheProbeFor: selector withShift: 1 baseRegOrNone: cacheBaseReg.
	self JumpZero: itsAHit.

	"Second probe missed.  Do last probe.  Shift hash right two and retry."
	jumpSelectorMiss jmpTarget: self Label.
	jumpSelectorMiss := self compileOpenPICMethodCacheProbeFor: selector withShift: 2 baseRegOrNone: cacheBaseReg.
	self JumpZero: itsAHit.

	"Last probe missed.  Call ceSendFromInLineCacheMiss: to do the full lookup."
	jumpSelectorMiss jmpTarget: self Label.
	self numRegArgs > 0 ifTrue:
		[backEnd genPushRegisterArgsForNumArgs: numArgs scratchReg: SendNumArgsReg].
	self genSmalltalkToCStackSwitch: true.
	methodLabel addDependent: (self annotateAbsolutePCRef: (self MoveCw: methodLabel asInteger R: SendNumArgsReg)).
	self 
		compileCallFor: #ceSendFromInLineCacheMiss:
		numArgs: 1
		arg: SendNumArgsReg
		arg: nil
		arg: nil
		arg: nil
		resultReg: NoReg
		regsToSave: self emptyRegisterMask
	"Note that this call does not return."