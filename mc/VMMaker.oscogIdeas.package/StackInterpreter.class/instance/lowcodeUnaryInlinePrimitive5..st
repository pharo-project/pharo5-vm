inline primitive dispatch generated code
lowcodeUnaryInlinePrimitive5: prim
	<option: #LowcodeVM>	"Lowcode instruction interpreter dispatch"
	prim
		caseOf: {
			[247]	-> [ ^ self lowcodePrimitiveZeroExtend64From32 ].
			[248]	-> [ ^ self lowcodePrimitiveZeroExtend64From8 ].
		}
		otherwise: [
			localIP := localIP - 3.
			^self respondToUnknownBytecode
		].
	

