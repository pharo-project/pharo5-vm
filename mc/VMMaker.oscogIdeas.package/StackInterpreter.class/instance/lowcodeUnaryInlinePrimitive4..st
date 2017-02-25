inline primitive dispatch generated code
lowcodeUnaryInlinePrimitive4: prim
	<option: #LowcodeVM>	"Lowcode instruction interpreter dispatch"
	prim
		caseOf: {
			[187]	-> [ ^ self lowcodePrimitivePushSessionIdentifier ].
			[188]	-> [ ^ self lowcodePrimitivePushZero32 ].
			[189]	-> [ ^ self lowcodePrimitivePushZero64 ].
			[190]	-> [ ^ self lowcodePrimitivePushZeroFloat32 ].
			[191]	-> [ ^ self lowcodePrimitivePushZeroFloat64 ].
			[192]	-> [ ^ self lowcodePrimitiveRem32 ].
			[193]	-> [ ^ self lowcodePrimitiveRem64 ].
			[194]	-> [ ^ self lowcodePrimitiveRightShift32 ].
			[195]	-> [ ^ self lowcodePrimitiveRightShift64 ].
			[196]	-> [ ^ self lowcodePrimitiveSignExtend32From16 ].
			[197]	-> [ ^ self lowcodePrimitiveSignExtend32From8 ].
			[198]	-> [ ^ self lowcodePrimitiveSignExtend64From16 ].
			[199]	-> [ ^ self lowcodePrimitiveSignExtend64From32 ].
			[200]	-> [ ^ self lowcodePrimitiveSignExtend64From8 ].
			[201]	-> [ ^ self lowcodePrimitiveStoreFloat32ToMemory ].
			[202]	-> [ ^ self lowcodePrimitiveStoreFloat64ToMemory ].
			[203]	-> [ ^ self lowcodePrimitiveStoreInt16ToMemory ].
			[204]	-> [ ^ self lowcodePrimitiveStoreInt32ToMemory ].
			[205]	-> [ ^ self lowcodePrimitiveStoreInt64ToMemory ].
			[206]	-> [ ^ self lowcodePrimitiveStoreInt8ToMemory ].
			[207]	-> [ ^ self lowcodePrimitiveStoreLocalFloat32 ].
			[208]	-> [ ^ self lowcodePrimitiveStoreLocalFloat64 ].
			[209]	-> [ ^ self lowcodePrimitiveStoreLocalInt16 ].
			[210]	-> [ ^ self lowcodePrimitiveStoreLocalInt32 ].
			[211]	-> [ ^ self lowcodePrimitiveStoreLocalInt64 ].
			[212]	-> [ ^ self lowcodePrimitiveStoreLocalInt8 ].
			[213]	-> [ ^ self lowcodePrimitiveStoreLocalPointer ].
			[214]	-> [ ^ self lowcodePrimitiveStorePointerToMemory ].
			[215]	-> [ ^ self lowcodePrimitiveSub32 ].
			[216]	-> [ ^ self lowcodePrimitiveSub64 ].
			[217]	-> [ ^ self lowcodePrimitiveTruncate32To16 ].
			[218]	-> [ ^ self lowcodePrimitiveTruncate32To8 ].
			[219]	-> [ ^ self lowcodePrimitiveTruncate64To16 ].
			[220]	-> [ ^ self lowcodePrimitiveTruncate64To32 ].
			[221]	-> [ ^ self lowcodePrimitiveTruncate64To8 ].
			[222]	-> [ ^ self lowcodePrimitiveUdiv32 ].
			[223]	-> [ ^ self lowcodePrimitiveUdiv64 ].
			[224]	-> [ ^ self lowcodePrimitiveUint32Great ].
			[225]	-> [ ^ self lowcodePrimitiveUint32GreatEqual ].
			[226]	-> [ ^ self lowcodePrimitiveUint32Less ].
			[227]	-> [ ^ self lowcodePrimitiveUint32LessEqual ].
			[228]	-> [ ^ self lowcodePrimitiveUint32ToFloat32 ].
			[229]	-> [ ^ self lowcodePrimitiveUint32ToFloat64 ].
			[230]	-> [ ^ self lowcodePrimitiveUint64Great ].
			[231]	-> [ ^ self lowcodePrimitiveUint64GreatEqual ].
			[232]	-> [ ^ self lowcodePrimitiveUint64Less ].
			[233]	-> [ ^ self lowcodePrimitiveUint64LessEqual ].
			[234]	-> [ ^ self lowcodePrimitiveUint64ToFloat32 ].
			[235]	-> [ ^ self lowcodePrimitiveUint64ToFloat64 ].
			[236]	-> [ ^ self lowcodePrimitiveUmul32 ].
			[237]	-> [ ^ self lowcodePrimitiveUmul64 ].
			[238]	-> [ ^ self lowcodePrimitiveUnlockRegisters ].
			[239]	-> [ ^ self lowcodePrimitiveUnlockVM ].
			[240]	-> [ ^ self lowcodePrimitiveUrem32 ].
			[241]	-> [ ^ self lowcodePrimitiveUrem64 ].
			[242]	-> [ ^ self lowcodePrimitiveXor32 ].
			[243]	-> [ ^ self lowcodePrimitiveXor64 ].
			[244]	-> [ ^ self lowcodePrimitiveZeroExtend32From16 ].
			[245]	-> [ ^ self lowcodePrimitiveZeroExtend32From8 ].
			[246]	-> [ ^ self lowcodePrimitiveZeroExtend64From16 ].
		}
		otherwise: [ ^ self lowcodeUnaryInlinePrimitive5: prim ].
	

