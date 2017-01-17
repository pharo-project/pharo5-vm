inline primitive generators dispatch generated code
genLowcodeUnaryInlinePrimitive: prim
	<option: #LowcodeVM>	"Lowcode instruction generator dispatch"
	prim
		caseOf: {
			[0]	-> [ ^ self genLowcodeAdd32 ].
			[1]	-> [ ^ self genLowcodeAdd64 ].
			[2]	-> [ ^ self genLowcodeAlloca32 ].
			[3]	-> [ ^ self genLowcodeAlloca64 ].
			[4]	-> [ ^ self genLowcodeAnd32 ].
			[5]	-> [ ^ self genLowcodeAnd64 ].
			[6]	-> [ ^ self genLowcodeArithmeticRightShift32 ].
			[7]	-> [ ^ self genLowcodeArithmeticRightShift64 ].
			[8]	-> [ ^ self genLowcodeBeginCall ].
			[9]	-> [ ^ self genLowcodeCallArgumentFloat32 ].
			[10]	-> [ ^ self genLowcodeCallArgumentFloat64 ].
			[11]	-> [ ^ self genLowcodeCallArgumentInt32 ].
			[12]	-> [ ^ self genLowcodeCallArgumentInt64 ].
			[13]	-> [ ^ self genLowcodeCallArgumentPointer ].
			[14]	-> [ ^ self genLowcodeCallArgumentSpace ].
			[15]	-> [ ^ self genLowcodeCallArgumentStructure ].
			[16]	-> [ ^ self genLowcodeCallInstruction ].
			[17]	-> [ ^ self genLowcodeCallPhysical ].
			[18]	-> [ ^ self genLowcodeCheckSessionIdentifier ].
			[19]	-> [ ^ self genLowcodeCompareAndSwap32 ].
			[20]	-> [ ^ self genLowcodeDiv32 ].
			[21]	-> [ ^ self genLowcodeDiv64 ].
			[22]	-> [ ^ self genLowcodeDuplicateFloat32 ].
			[23]	-> [ ^ self genLowcodeDuplicateFloat64 ].
			[24]	-> [ ^ self genLowcodeDuplicateInt32 ].
			[25]	-> [ ^ self genLowcodeDuplicateInt64 ].
			[26]	-> [ ^ self genLowcodeDuplicatePointer ].
			[27]	-> [ ^ self genLowcodeEffectiveAddress32 ].
			[28]	-> [ ^ self genLowcodeEffectiveAddress64 ].
			[29]	-> [ ^ self genLowcodeEndCall ].
			[30]	-> [ ^ self genLowcodeEndCallNoCleanup ].
			[31]	-> [ ^ self genLowcodeFloat32Add ].
			[32]	-> [ ^ self genLowcodeFloat32Div ].
			[33]	-> [ ^ self genLowcodeFloat32Equal ].
			[34]	-> [ ^ self genLowcodeFloat32Great ].
			[35]	-> [ ^ self genLowcodeFloat32GreatEqual ].
			[36]	-> [ ^ self genLowcodeFloat32Less ].
			[37]	-> [ ^ self genLowcodeFloat32LessEqual ].
			[38]	-> [ ^ self genLowcodeFloat32Mul ].
			[39]	-> [ ^ self genLowcodeFloat32Neg ].
			[40]	-> [ ^ self genLowcodeFloat32NotEqual ].
			[41]	-> [ ^ self genLowcodeFloat32Sqrt ].
			[42]	-> [ ^ self genLowcodeFloat32Sub ].
			[43]	-> [ ^ self genLowcodeFloat32ToFloat64 ].
			[44]	-> [ ^ self genLowcodeFloat32ToInt32 ].
			[45]	-> [ ^ self genLowcodeFloat32ToInt64 ].
			[46]	-> [ ^ self genLowcodeFloat32ToUInt32 ].
			[47]	-> [ ^ self genLowcodeFloat32ToUInt64 ].
			[48]	-> [ ^ self genLowcodeFloat64Add ].
			[49]	-> [ ^ self genLowcodeFloat64Div ].
			[50]	-> [ ^ self genLowcodeFloat64Equal ].
			[51]	-> [ ^ self genLowcodeFloat64Great ].
			[52]	-> [ ^ self genLowcodeFloat64GreatEqual ].
			[53]	-> [ ^ self genLowcodeFloat64Less ].
			[54]	-> [ ^ self genLowcodeFloat64LessEqual ].
			[55]	-> [ ^ self genLowcodeFloat64Mul ].
			[56]	-> [ ^ self genLowcodeFloat64Neg ].
			[57]	-> [ ^ self genLowcodeFloat64NotEqual ].
			[58]	-> [ ^ self genLowcodeFloat64Sqrt ].
			[59]	-> [ ^ self genLowcodeFloat64Sub ].
		}
		otherwise: [ ^ self genLowcodeUnaryInlinePrimitive2: prim ].
	^ 0

