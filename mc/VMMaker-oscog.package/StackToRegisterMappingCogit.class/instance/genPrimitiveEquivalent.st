primitive generators
genPrimitiveEquivalent
	"Receiver and arg in registers.
	 Stack looks like
		return address"
	| jumpFalse |
	<var: #jumpFalse type: #'AbstractInstruction *'>
	self CmpR: Arg0Reg R: ReceiverResultReg.
	jumpFalse := self JumpNonZero: 0.
	self annotate: (self MoveCw: objectMemory trueObject R: ReceiverResultReg)
		objRef: objectMemory trueObject.
	self RetN: 0.
	jumpFalse jmpTarget: (self annotate: (self MoveCw: objectMemory falseObject R: ReceiverResultReg)
								objRef: objectMemory falseObject).
	self RetN: 0.
	^0