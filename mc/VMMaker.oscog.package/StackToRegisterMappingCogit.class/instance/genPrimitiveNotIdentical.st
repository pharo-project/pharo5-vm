primitive generators
genPrimitiveNotIdentical
	"Receiver and arg in registers.
	 Stack looks like
		return address"
	^objectRepresentation
		genInnerPrimitiveIdentical: 0
		orNotIf: true