primitive generators
genPrimitiveIdentityHash
	"Arguably we should fail for immediates, but so far no one has complained, so..."
	| jumpImm jumpSI jumpNotSet ret |
	<var: #jumpSI type: #'AbstractInstruction *'>
	<var: #jumpImm type: #'AbstractInstruction *'>
	<var: #jumpNotSet type: #'AbstractInstruction *'>
	jumpImm := self genJumpImmediate: ReceiverResultReg.
	self genGetHashFieldNonImmOf: ReceiverResultReg asSmallIntegerInto: TempReg.
	cogit CmpCq: ConstZero R: TempReg.
	jumpNotSet := cogit JumpZero: 0.
	cogit MoveR: TempReg R: ReceiverResultReg.
	ret := cogit genPrimReturn.
	jumpImm jmpTarget: cogit Label.
	jumpSI := self genJumpSmallInteger: ReceiverResultReg.
	jumpSI jmpTarget: ret.
	self genConvertCharacterToSmallIntegerInReg: ReceiverResultReg.
	cogit Jump: ret.
	jumpNotSet jmpTarget: cogit Label.
	^0