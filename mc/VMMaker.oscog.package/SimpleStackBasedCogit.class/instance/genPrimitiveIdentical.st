primitive generators
genPrimitiveIdentical
	"Stack looks like
		receiver (also in ResultReceiverReg)
		arg
		return address"
	self MoveMw: BytesPerWord r: SPReg R: TempReg.
	^objectRepresentation
		genInnerPrimitiveIdentical: BytesPerWord * 2
		orNotIf: false