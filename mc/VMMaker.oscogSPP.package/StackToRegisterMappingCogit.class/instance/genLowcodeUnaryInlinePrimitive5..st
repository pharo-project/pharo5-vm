inline primitive generators dispatch generated code
genLowcodeUnaryInlinePrimitive5: prim
	<option: #LowcodeVM>	"Lowcode instruction generator dispatch"
	prim
		caseOf: {
			[240]	-> [ ^ self genLowcodeUrem32 ].
			[241]	-> [ ^ self genLowcodeUrem64 ].
			[242]	-> [ ^ self genLowcodeXor32 ].
			[243]	-> [ ^ self genLowcodeXor64 ].
			[244]	-> [ ^ self genLowcodeZeroExtend32From16 ].
			[245]	-> [ ^ self genLowcodeZeroExtend32From8 ].
			[246]	-> [ ^ self genLowcodeZeroExtend64From16 ].
			[247]	-> [ ^ self genLowcodeZeroExtend64From32 ].
			[248]	-> [ ^ self genLowcodeZeroExtend64From8 ].
		}
		otherwise: [ ^ EncounteredUnknownBytecode ].
	^ 0

