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
	"For non-behaviors we can call ceNewHash to assign a fresh hash.
	 For behaviors we must fail into the interpreter primitive to enter the receiver into the class table."
	cogit primitiveIndex = 75 ifFalse:
		[^0].
	cogit
		CallRT: ceNewHashTrampoline;
		genPrimReturn.
	^UnfailingPrimitive