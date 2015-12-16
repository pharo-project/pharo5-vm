in-line cacheing
compileOpenPICMethodCacheProbeFor: selector withShift: shift baseRegOrNone: baseRegOrNone
	"Compile one method cache probe in an OpenPIC's lookup of selector.  Answer the jump taken if the selector probe fails."
	<returnTypeC: #'AbstractInstruction *'>
	<inline: false>
	| jumpSelectorMiss |
	<var: 'jumpSelectorMiss' type: #'AbstractInstruction *'>
	self MoveR: SendNumArgsReg R: ClassReg.
	self annotate: (self XorCw: selector R: ClassReg) objRef: selector.
	objectMemory shiftForWord > shift ifTrue:
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