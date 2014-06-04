primitive generators
genInnerPrimitiveIdentityHash: retNoffset
	| jumpImm jumpSI jumpNotSet ret |
	<var: #jumpSI type: #'AbstractInstruction *'>
	<var: #jumpImm type: #'AbstractInstruction *'>
	<var: #jumpNotSet type: #'AbstractInstruction *'>
	cogit MoveR: ReceiverResultReg R: ClassReg.
	jumpImm := self genJumpImmediateInScratchReg: ClassReg.
	self genGetHashFieldNonImmOf: ReceiverResultReg asSmallIntegerInto: TempReg.
	cogit CmpCq: ConstZero R: TempReg.
	jumpNotSet := cogit JumpZero: 0.
	cogit MoveR: TempReg R: ReceiverResultReg.
	ret := cogit RetN: 0.
	jumpImm jmpTarget: (cogit MoveR: ReceiverResultReg R: ClassReg).
	jumpSI := self genJumpSmallIntegerInScratchReg: ClassReg.
	jumpSI jmpTarget: ret.
	self genConvertCharacterToSmallIntegerInReg: ReceiverResultReg.
	cogit Jump: ret.
	jumpNotSet jmpTarget: cogit Label.
	^0