primitive generators
genPrimitiveBitXor
	| jumpNotSI |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	cogit mclassIsSmallInteger ifFalse:
		[^UnimplementedPrimitive].
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	jumpNotSI := self genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	"Clear one or the other tag so that xoring will preserve them."
	self genRemoveSmallIntegerTagsInScratchReg: Arg0Reg.
	cogit XorR: Arg0Reg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpNotSI jmpTarget: cogit Label.
	^CompletePrimitive