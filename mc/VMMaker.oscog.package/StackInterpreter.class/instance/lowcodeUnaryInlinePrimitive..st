inline primitive dispatch generated code
lowcodeUnaryInlinePrimitive: prim
	<option: #LowcodeVM>	"Lowcode instruction interpreter dispatch"
	prim
		caseOf: {
			[0]	-> [ ^ self lowcodePrimitiveAdd32 ].
			[1]	-> [ ^ self lowcodePrimitiveAdd64 ].
			[2]	-> [ ^ self lowcodePrimitiveAlloca32 ].
			[3]	-> [ ^ self lowcodePrimitiveAlloca64 ].
			[4]	-> [ ^ self lowcodePrimitiveAnd32 ].
			[5]	-> [ ^ self lowcodePrimitiveAnd64 ].
			[6]	-> [ ^ self lowcodePrimitiveArithmeticRightShift32 ].
			[7]	-> [ ^ self lowcodePrimitiveArithmeticRightShift64 ].
			[8]	-> [ ^ self lowcodePrimitiveBeginCall ].
			[9]	-> [ ^ self lowcodePrimitiveCallArgumentFloat32 ].
			[10]	-> [ ^ self lowcodePrimitiveCallArgumentFloat64 ].
			[11]	-> [ ^ self lowcodePrimitiveCallArgumentInt32 ].
			[12]	-> [ ^ self lowcodePrimitiveCallArgumentInt64 ].
			[13]	-> [ ^ self lowcodePrimitiveCallArgumentPointer ].
			[14]	-> [ ^ self lowcodePrimitiveCallArgumentSpace ].
			[15]	-> [ ^ self lowcodePrimitiveCallArgumentStructure ].
			[16]	-> [ ^ self lowcodePrimitiveCallInstruction ].
			[17]	-> [ ^ self lowcodePrimitiveCallPhysical ].
			[18]	-> [ ^ self lowcodePrimitiveCheckSessionIdentifier ].
			[19]	-> [ ^ self lowcodePrimitiveCompareAndSwap32 ].
			[20]	-> [ ^ self lowcodePrimitiveDiv32 ].
			[21]	-> [ ^ self lowcodePrimitiveDiv64 ].
			[22]	-> [ ^ self lowcodePrimitiveDuplicateFloat32 ].
			[23]	-> [ ^ self lowcodePrimitiveDuplicateFloat64 ].
			[24]	-> [ ^ self lowcodePrimitiveDuplicateInt32 ].
			[25]	-> [ ^ self lowcodePrimitiveDuplicateInt64 ].
			[26]	-> [ ^ self lowcodePrimitiveDuplicatePointer ].
			[27]	-> [ ^ self lowcodePrimitiveEffectiveAddress32 ].
			[28]	-> [ ^ self lowcodePrimitiveEffectiveAddress64 ].
			[29]	-> [ ^ self lowcodePrimitiveEndCall ].
			[30]	-> [ ^ self lowcodePrimitiveEndCallNoCleanup ].
			[31]	-> [ ^ self lowcodePrimitiveFloat32Add ].
			[32]	-> [ ^ self lowcodePrimitiveFloat32Div ].
			[33]	-> [ ^ self lowcodePrimitiveFloat32Equal ].
			[34]	-> [ ^ self lowcodePrimitiveFloat32Great ].
			[35]	-> [ ^ self lowcodePrimitiveFloat32GreatEqual ].
			[36]	-> [ ^ self lowcodePrimitiveFloat32Less ].
			[37]	-> [ ^ self lowcodePrimitiveFloat32LessEqual ].
			[38]	-> [ ^ self lowcodePrimitiveFloat32Mul ].
			[39]	-> [ ^ self lowcodePrimitiveFloat32Neg ].
			[40]	-> [ ^ self lowcodePrimitiveFloat32NotEqual ].
			[41]	-> [ ^ self lowcodePrimitiveFloat32Sqrt ].
			[42]	-> [ ^ self lowcodePrimitiveFloat32Sub ].
			[43]	-> [ ^ self lowcodePrimitiveFloat32ToFloat64 ].
			[44]	-> [ ^ self lowcodePrimitiveFloat32ToInt32 ].
			[45]	-> [ ^ self lowcodePrimitiveFloat32ToInt64 ].
			[46]	-> [ ^ self lowcodePrimitiveFloat32ToUInt32 ].
			[47]	-> [ ^ self lowcodePrimitiveFloat32ToUInt64 ].
			[48]	-> [ ^ self lowcodePrimitiveFloat64Add ].
			[49]	-> [ ^ self lowcodePrimitiveFloat64Div ].
			[50]	-> [ ^ self lowcodePrimitiveFloat64Equal ].
			[51]	-> [ ^ self lowcodePrimitiveFloat64Great ].
			[52]	-> [ ^ self lowcodePrimitiveFloat64GreatEqual ].
			[53]	-> [ ^ self lowcodePrimitiveFloat64Less ].
			[54]	-> [ ^ self lowcodePrimitiveFloat64LessEqual ].
			[55]	-> [ ^ self lowcodePrimitiveFloat64Mul ].
			[56]	-> [ ^ self lowcodePrimitiveFloat64Neg ].
			[57]	-> [ ^ self lowcodePrimitiveFloat64NotEqual ].
			[58]	-> [ ^ self lowcodePrimitiveFloat64Sqrt ].
			[59]	-> [ ^ self lowcodePrimitiveFloat64Sub ].
		}
		otherwise: [ ^ self lowcodeUnaryInlinePrimitive2: prim ].
	

