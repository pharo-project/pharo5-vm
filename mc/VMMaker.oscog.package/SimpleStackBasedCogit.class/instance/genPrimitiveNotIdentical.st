primitive generators
genPrimitiveNotIdentical
	"Stack looks like
		receiver (also in ResultReceiverReg)
		arg
		return address"
	self genLoadArgAtDepth: 0 into: Arg0Reg.
	^objectRepresentation
		genInnerPrimitiveIdentical: (self primRetNOffsetFor: 1)
		orNotIf: true