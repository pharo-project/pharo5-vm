in-line cacheing
compilePerformMethodCacheProbeFor: selectorReg withShift: shift baseRegOrNone: baseRegOrNone
	"Compile one method cache probe in a perform: primitive's lookup of selector.
	 Answer the jump taken if the selector probe fails."
	<returnTypeC: #'AbstractInstruction *'>
	<inline: false>
	| jumpSelectorMiss |
	<var: 'jumpSelectorMiss' type: #'AbstractInstruction *'>
	self MoveR: SendNumArgsReg R: ClassReg.
	objectRepresentation maybeShiftClassTagRegisterForMethodCacheProbe: ClassReg.
	self XorR: selectorReg R: ClassReg.
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
	self CmpR: selectorReg R: TempReg.
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