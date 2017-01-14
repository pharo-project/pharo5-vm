primitive generators
genPrimitiveBitShift
	"rTemp := rArg0
	rClass := tTemp
	rTemp := rTemp & 1
	jz nonInt
	rClass >>= 1
	cmp 0,rClass
	jge neg
	cmp 31,rClass // numSmallIntegerBits, jge for sign
	jge tooBig
	rTemp := rReceiver
	rTemp <<= rClass
	rTemp >>= rClass (arithmetic)
	cmp rTemp,rReceiver
	jnz ovfl
	rReceiver := rReceiver - 1
	rReceiver := rReceiver <<= rClass
	rReceiver := rReceiver + 1
	ret
neg:
	rClass := 0 - rClass
	cmp 31,rClass // numSmallIntegerBits
	jge inRange
	rClass := 31
inRange
	rReceiver := rReceiver >>= rClass.
	rReceiver := rReceiver | smallIntegerTags.
	ret
ovfl
tooBig
nonInt:
	fail"
	| jumpNotSI jumpOvfl jumpNegative jumpTooBig jumpInRange |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpOvfl type: #'AbstractInstruction *'>
	<var: #jumpNegative type: #'AbstractInstruction *'>
	<var: #jumpTooBig type: #'AbstractInstruction *'>
	<var: #jumpInRange type: #'AbstractInstruction *'>
	cogit mclassIsSmallInteger ifFalse:
		[^UnimplementedPrimitive].
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	cogit MoveR: Arg0Reg R: ClassReg.
	jumpNotSI := self genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	self genConvertSmallIntegerToIntegerInReg: ClassReg.
	(cogit lastOpcode setsConditionCodesFor: JumpNegative) ifFalse:
		[cogit CmpCq: 0 R: ClassReg]. "N.B. FLAGS := ClassReg - 0"
	jumpNegative := cogit JumpNegative: 0.
	cogit CmpCq: self numSmallIntegerBits R: ClassReg. "N.B. FLAGS := ClassReg - numSmallIntegerBits"
	jumpTooBig := cogit JumpGreaterOrEqual: 0.
	cogit MoveR: ReceiverResultReg R: TempReg.
	cogit LogicalShiftLeftR: ClassReg R: TempReg.
	cogit ArithmeticShiftRightR: ClassReg R: TempReg.
	cogit CmpR: TempReg R: ReceiverResultReg. "N.B. FLAGS := RRReg - TempReg"
	jumpOvfl := cogit JumpNonZero: 0.
	self genRemoveSmallIntegerTagsInScratchReg: ReceiverResultReg.
	cogit LogicalShiftLeftR: ClassReg R: ReceiverResultReg.
	self genAddSmallIntegerTagsTo: ReceiverResultReg.
	cogit genPrimReturn.
	jumpNegative jmpTarget: (cogit NegateR: ClassReg).
	cogit CmpCq: self numSmallIntegerBits R: ClassReg. "N.B. FLAGS := ClassReg - numSmallIntegerBits"
	jumpInRange := cogit JumpLessOrEqual: 0.
	cogit MoveCq: self numSmallIntegerBits R: ClassReg.
	jumpInRange jmpTarget: (cogit ArithmeticShiftRightR: ClassReg R: ReceiverResultReg).
	self genClearAndSetSmallIntegerTagsIn: ReceiverResultReg.
	cogit genPrimReturn.
	jumpNotSI jmpTarget: (jumpTooBig jmpTarget: (jumpOvfl jmpTarget: cogit Label)).
	^CompletePrimitive