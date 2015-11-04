primitive generators
genInnerPrimitiveIdentityHash: retNoffset
	| jumpImm jumpSI jumpSF jumpNotSet ret |
	<var: #jumpSI type: #'AbstractInstruction *'>
	<var: #jumpSF type: #'AbstractInstruction *'>
	<var: #jumpImm type: #'AbstractInstruction *'>
	<var: #jumpNotSet type: #'AbstractInstruction *'>
	jumpImm := self genJumpImmediate: ReceiverResultReg.
	self genGetHashFieldNonImmOf: ReceiverResultReg asSmallIntegerInto: TempReg.
	cogit CmpCq: ConstZero R: TempReg.
	jumpNotSet := cogit JumpZero: 0.
	cogit MoveR: TempReg R: ReceiverResultReg.
	ret := cogit RetN: retNoffset.
	jumpImm jmpTarget: cogit Label.
	jumpSI := self genJumpSmallInteger: ReceiverResultReg.
	jumpSI asInteger = UnimplementedOperation ifTrue:
		[cogit MoveR: ReceiverResultReg R: TempReg.
		 jumpSI := self genJumpSmallIntegerInScratchReg: TempReg].
	jumpSI jmpTarget: ret.
	"Fail SmallFloat because their hash uses rotatedFloatBitsOf: the oop"
	jumpSF := self genJumpSmallFloat: ReceiverResultReg.
	jumpSF asInteger = UnimplementedOperation ifTrue:
		[cogit MoveR: ReceiverResultReg R: TempReg.
		 jumpSI := self genJumpSmallFloatInScratchReg: TempReg].
	self genConvertCharacterToSmallIntegerInReg: ReceiverResultReg.
	cogit Jump: ret.
	jumpNotSet jmpTarget: (jumpSF jmpTarget: cogit Label).
	^0