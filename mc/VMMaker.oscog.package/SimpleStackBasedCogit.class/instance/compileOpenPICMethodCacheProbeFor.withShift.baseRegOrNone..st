in-line cacheing
compileOpenPICMethodCacheProbeFor: selector withShift: shift baseRegOrNone: baseRegOrNone
	"Compile one method cache probe in an OpenPIC's lookup of selector.
	 Answer the jump taken if the selector probe fails.
	 The class tag of the receiver must be in SendNumArgsReg.  ClassReg and TempReg are used as scratch registers.
	 On a hit, the offset of the entry is in ClassReg."
	<returnTypeC: #'AbstractInstruction *'>
	<inline: false>
	| jumpSelectorMiss |
	<var: 'jumpSelectorMiss' type: #'AbstractInstruction *'>
	self MoveR: SendNumArgsReg R: ClassReg.
	objectRepresentation maybeShiftClassTagRegisterForMethodCacheProbe: ClassReg.
	self annotate: (self XorCw: selector R: ClassReg) objRef: selector.
	self assert: shift <= objectMemory shiftForWord.
	"Need to shift the hash right by shift to form the probe, and then shift the probe left by shiftForWord to form the index.
	 So shift left by shiftForWord - shift and and with the shifted mask."
	shift < objectMemory shiftForWord ifTrue:
		[self LogicalShiftLeftCq: objectMemory shiftForWord - shift R: ClassReg].
	self AndCq: MethodCacheMask << objectMemory shiftForWord R: ClassReg.
	baseRegOrNone = NoReg
		ifTrue:
			[self MoveMw: coInterpreter methodCacheAddress asUnsignedInteger + (MethodCacheSelector << objectMemory shiftForWord)
				r: ClassReg
				R: TempReg]
		ifFalse:
			[self AddR: baseRegOrNone R: ClassReg;
				MoveMw: MethodCacheSelector << objectMemory shiftForWord r: ClassReg R: TempReg].
	self annotate: (self CmpCw: selector R: TempReg) objRef: selector.
	jumpSelectorMiss := self JumpNonZero: 0.
	baseRegOrNone = NoReg
		ifTrue:
			[self MoveMw: coInterpreter methodCacheAddress asUnsignedInteger + (MethodCacheClass << objectMemory shiftForWord)
				r: ClassReg
				R: TempReg]
		ifFalse:
			[self MoveMw: MethodCacheClass << objectMemory shiftForWord r: ClassReg R: TempReg].
	self CmpR: SendNumArgsReg R: TempReg.
	^jumpSelectorMiss