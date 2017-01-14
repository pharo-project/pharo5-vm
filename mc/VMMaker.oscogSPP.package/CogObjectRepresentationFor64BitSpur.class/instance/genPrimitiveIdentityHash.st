primitive generators
genPrimitiveIdentityHash
	"Arguably we should fail for immediates, but so far no one has complained, so..."
	| jumpImm jumpNotSet jumpNotCharacter ret |
	<var: #jumpImm type: #'AbstractInstruction *'>
	<var: #jumpNotSet type: #'AbstractInstruction *'>
	<var: #jumpNotCharacter type: #'AbstractInstruction *'>
	jumpImm := self genJumpImmediate: ReceiverResultReg. "uses TstCqR"
	self genGetHashFieldNonImmOf: ReceiverResultReg asSmallIntegerInto: TempReg.
	cogit CmpCq: ConstZero R: TempReg.
	jumpNotSet := cogit JumpZero: 0.
	cogit MoveR: TempReg R: ReceiverResultReg.
	ret := cogit genPrimReturn.
	jumpImm jmpTarget: (cogit AndCq: objectMemory tagMask R: ReceiverResultReg R: TempReg).
	cogit CmpCq: objectMemory characterTag R: TempReg.
	jumpNotCharacter := cogit JumpNonZero: 0.
	self genConvertCharacterToSmallIntegerInReg: ReceiverResultReg.
	ret := cogit genPrimReturn.
	jumpNotCharacter jmpTarget: (cogit CmpCq: objectMemory smallFloatTag R: TempReg).
	cogit JumpNonZero: ret.
	self genConvertSmallFloatToSmallFloatHashAsIntegerInReg: ReceiverResultReg scratch: TempReg.
	cogit genPrimReturn.
	jumpNotSet jmpTarget: cogit Label.
	^0