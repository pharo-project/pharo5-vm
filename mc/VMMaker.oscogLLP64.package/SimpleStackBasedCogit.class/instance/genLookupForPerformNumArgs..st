primitive generators
genLookupForPerformNumArgs: numArgs
	"Compile the code for a probe of the first-level method cache for a perform primtiive.
	 The selector is assumed to be in Arg0Reg.  Defer to adjustArgumentsForPerform: to
	 adjust the arguments before the jump to the method."
	| jumpSelectorMiss jumpClassMiss jumpInterpret itsAHit cacheBaseReg |
	<var: #jumpSelectorMiss type: #'AbstractInstruction *'>
	<var: #jumpClassMiss type: #'AbstractInstruction *'>
	<var: #jumpInterpret type: #'AbstractInstruction *'>
	<var: #itsAHit type: #'AbstractInstruction *'>

	"N.B.  Can't assume TempReg already contains the tag because a method can
	 of course be invoked via the unchecked entry-point, e.g. as does perform:."
	objectRepresentation genGetInlineCacheClassTagFrom: ReceiverResultReg into: SendNumArgsReg forEntry: false.

	self flag: #lookupInMethodCacheSel:classTag:. "so this method shows up as a sender of lookupInMethodCacheSel:class:"

	cacheBaseReg := NoReg.
	(backEnd isWithinMwOffsetRange: coInterpreter methodCacheAddress) ifFalse:
		[self MoveCq: coInterpreter methodCacheAddress R: (cacheBaseReg := Extra0Reg)].

	"Do first of three probes.  See CoInterpreter>>lookupInMethodCacheSel:classTag:"
	jumpSelectorMiss := self compilePerformMethodCacheProbeFor: Arg0Reg withShift: 0 baseRegOrNone: cacheBaseReg.
	jumpClassMiss := self JumpNonZero: 0.

	"Fetch the method, and check if it is cogged."
	itsAHit := self MoveMw: (cacheBaseReg = NoReg
								ifTrue: [coInterpreter methodCacheAddress asUnsignedInteger + (MethodCacheMethod << objectMemory shiftForWord)]
								ifFalse: [MethodCacheMethod << objectMemory shiftForWord])
					r: ClassReg
					R: SendNumArgsReg.
	"If the method is not compiled fall back on the interpreter primitive."
	objectRepresentation genLoadSlot: HeaderIndex sourceReg: SendNumArgsReg destReg: ClassReg.
	jumpInterpret := objectRepresentation genJumpImmediate: ClassReg.
	"Adjust arguments and jump to the method's unchecked entry-point."
	self AddCq: cmNoCheckEntryOffset R: ClassReg.
	self adjustArgumentsForPerform: numArgs.
	self JumpR: ClassReg.

	"First probe missed.  Do second of three probes.  Shift hash right one and retry."
	jumpSelectorMiss jmpTarget: (jumpClassMiss jmpTarget: self Label).
	jumpSelectorMiss := self compilePerformMethodCacheProbeFor: Arg0Reg withShift: 1 baseRegOrNone: cacheBaseReg.
	self JumpZero: itsAHit.

	"Second probe missed.  Do last probe.  Shift hash right two and retry."
	jumpSelectorMiss jmpTarget: self Label.
	jumpSelectorMiss := self compilePerformMethodCacheProbeFor: Arg0Reg withShift: 2 baseRegOrNone: cacheBaseReg.
	self JumpZero: itsAHit.

	"Last probe missed.  Caller will generate the call to fall back on the interpreter primitive."
	jumpSelectorMiss jmpTarget:
	(jumpInterpret jmpTarget: self Label).
	^0