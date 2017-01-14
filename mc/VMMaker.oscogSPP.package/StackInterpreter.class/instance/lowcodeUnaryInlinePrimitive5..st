inline primitive dispatch generated code
lowcodeUnaryInlinePrimitive5: prim
	<option: #LowcodeVM>	"Lowcode instruction interpreter dispatch"
	prim
		caseOf: {
			[240]	-> [ ^ self lowcodePrimitiveUrem32 ].
			[241]	-> [ ^ self lowcodePrimitiveUrem64 ].
			[242]	-> [ ^ self lowcodePrimitiveXor32 ].
			[243]	-> [ ^ self lowcodePrimitiveXor64 ].
			[244]	-> [ ^ self lowcodePrimitiveZeroExtend32From16 ].
			[245]	-> [ ^ self lowcodePrimitiveZeroExtend32From8 ].
			[246]	-> [ ^ self lowcodePrimitiveZeroExtend64From16 ].
			[247]	-> [ ^ self lowcodePrimitiveZeroExtend64From32 ].
			[248]	-> [ ^ self lowcodePrimitiveZeroExtend64From8 ].
		}
		otherwise: [
			localIP := localIP - 3.
			^self respondToUnknownBytecode
		].
	

