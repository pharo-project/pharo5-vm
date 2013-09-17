primitive generators
genPrimitiveClass
	"Stack looks like
		receiver (also in ReceiverResultReg)
		return address"
	objectRepresentation genGetClassObjectOf: ReceiverResultReg into: ReceiverResultReg scratchReg: TempReg.
	self flag: 'currently caller pushes result'.
	self RetN: BytesPerWord.
	^0