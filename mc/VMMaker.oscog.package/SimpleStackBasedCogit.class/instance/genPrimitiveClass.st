primitive generators
genPrimitiveClass
	"Stack looks like
		receiver (also in ReceiverResultReg)
		return address"
	(objectRepresentation
			genGetClassObjectOf: ReceiverResultReg
			into: ReceiverResultReg
			scratchReg: TempReg
			instRegIsReceiver: methodOrBlockNumArgs = 0) = BadRegisterSet ifTrue:
		[objectRepresentation
			genGetClassObjectOf: ReceiverResultReg
			into: ClassReg
			scratchReg: TempReg
			instRegIsReceiver: methodOrBlockNumArgs = 0.
		 self MoveR: ClassReg R: ReceiverResultReg].
	self flag: 'currently caller pushes result'.
	self RetN: BytesPerWord.
	^0