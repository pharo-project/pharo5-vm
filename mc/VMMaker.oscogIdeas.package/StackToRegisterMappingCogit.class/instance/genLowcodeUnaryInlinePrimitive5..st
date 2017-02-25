inline primitive generators dispatch generated code
genLowcodeUnaryInlinePrimitive5: prim
	<option: #LowcodeVM>	"Lowcode instruction generator dispatch"
	prim
		caseOf: {
			[247]	-> [ ^ self genLowcodeZeroExtend64From32 ].
			[248]	-> [ ^ self genLowcodeZeroExtend64From8 ].
		}
		otherwise: [ ^ EncounteredUnknownBytecode ].
	^ 0

