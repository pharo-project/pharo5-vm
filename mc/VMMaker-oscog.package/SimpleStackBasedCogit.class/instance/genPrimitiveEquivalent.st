primitive generators
genPrimitiveEquivalent
	"Stack looks like
		receiver (also in ResultReceiverReg)
		arg
		return address"
	| jumpFalse |
	<var: #jumpFalse type: #'AbstractInstruction *'>
	self MoveMw: BytesPerWord r: SPReg R: TempReg.
	self CmpR: TempReg R: ReceiverResultReg.
	jumpFalse := self JumpNonZero: 0.
	self annotate: (self MoveCw: objectMemory trueObject R: ReceiverResultReg)
		objRef: objectMemory trueObject.
	self flag: 'currently caller pushes result'.
	self RetN: BytesPerWord * 2.
	jumpFalse jmpTarget: (self annotate: (self MoveCw: objectMemory falseObject R: ReceiverResultReg)
								objRef: objectMemory falseObject).
	self RetN: BytesPerWord * 2.
	^0