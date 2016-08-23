primitive generators
genSmallIntegerComparison: jumpOpcode orDoubleComparison: jumpFPOpcodeGenerator invert: invertComparison
	"Stack looks like
		return address"
	| jumpNonInt jumpFail jumpCond r |
	<var: #jumpFPOpcodeGenerator declareC: 'AbstractInstruction *(*jumpFPOpcodeGenerator)(void *)'>
	<var: #jumpNonInt type: #'AbstractInstruction *'>
	<var: #jumpCond type: #'AbstractInstruction *'>
	<var: #jumpFail type: #'AbstractInstruction *'>
	r := self genSmallIntegerComparison: jumpOpcode.
	r < 0 ifTrue:
		[^r].
	self cppIf: #DPFPReg0 defined ifTrue:
	"Fall through on non-SmallInteger argument.  Argument may be a Float : let us check or fail"
	[self smallIntegerIsOnlyImmediateType ifFalse:
		[jumpNonInt := self genJumpImmediate: Arg0Reg].
	self genGetCompactClassIndexNonImmOf: Arg0Reg into: SendNumArgsReg.
	self genCmpClassFloatCompactIndexR: SendNumArgsReg.
	jumpFail := cogit JumpNonZero: 0.

	"It was a Float, so convert the receiver to double and perform the operation"
	self genConvertSmallIntegerToIntegerInReg: ReceiverResultReg.
	cogit ConvertR: ReceiverResultReg Rd: DPFPReg0.
	self genGetDoubleValueOf: Arg0Reg into: DPFPReg1.
	invertComparison "May need to invert for NaNs"
		ifTrue: [cogit CmpRd: DPFPReg0 Rd: DPFPReg1]
		ifFalse: [cogit CmpRd: DPFPReg1 Rd: DPFPReg0].
	jumpCond := cogit perform: jumpFPOpcodeGenerator with: 0. "FP jumps are a little weird"
	cogit genMoveFalseR: ReceiverResultReg.
	cogit genPrimReturn.
	jumpCond jmpTarget: (cogit genMoveTrueR: ReceiverResultReg).
	cogit genPrimReturn.

	self smallIntegerIsOnlyImmediateType
		ifTrue: [jumpFail jmpTarget: cogit Label]
		ifFalse: [jumpNonInt jmpTarget: (jumpFail jmpTarget: cogit Label)]].
	^CompletePrimitive