primitive generators
genPrimitiveIdentical
	"Stack looks like
		receiver (also in ResultReceiverReg)
		arg
		return address"
	self MoveMw: objectMemory wordSize r: SPReg R: TempReg.
	^objectRepresentation
		genInnerPrimitiveIdentical: objectMemory wordSize * 2
		orNotIf: false