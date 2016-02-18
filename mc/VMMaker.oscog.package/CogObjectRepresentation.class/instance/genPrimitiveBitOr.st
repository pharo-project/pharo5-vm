primitive generators
genPrimitiveBitOr
	| jumpNotSI |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	cogit mclassIsSmallInteger ifFalse:
		[^UnimplementedPrimitive].
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	jumpNotSI := self genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	"Whether the SmallInteger tags are zero or non-zero, oring them together will preserve them."
	cogit OrR: Arg0Reg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpNotSI jmpTarget: cogit Label.
	^CompletePrimitive