inline primitive generators dispatch generated code
genLowcodeUnaryInlinePrimitive4: prim
	<option: #LowcodeVM>	"Lowcode instruction generator dispatch"
	prim
		caseOf: {
			[187]	-> [ ^ self genLowcodePushSessionIdentifier ].
			[188]	-> [ ^ self genLowcodePushZero32 ].
			[189]	-> [ ^ self genLowcodePushZero64 ].
			[190]	-> [ ^ self genLowcodePushZeroFloat32 ].
			[191]	-> [ ^ self genLowcodePushZeroFloat64 ].
			[192]	-> [ ^ self genLowcodeRem32 ].
			[193]	-> [ ^ self genLowcodeRem64 ].
			[194]	-> [ ^ self genLowcodeRightShift32 ].
			[195]	-> [ ^ self genLowcodeRightShift64 ].
			[196]	-> [ ^ self genLowcodeSignExtend32From16 ].
			[197]	-> [ ^ self genLowcodeSignExtend32From8 ].
			[198]	-> [ ^ self genLowcodeSignExtend64From16 ].
			[199]	-> [ ^ self genLowcodeSignExtend64From32 ].
			[200]	-> [ ^ self genLowcodeSignExtend64From8 ].
			[201]	-> [ ^ self genLowcodeStoreFloat32ToMemory ].
			[202]	-> [ ^ self genLowcodeStoreFloat64ToMemory ].
			[203]	-> [ ^ self genLowcodeStoreInt16ToMemory ].
			[204]	-> [ ^ self genLowcodeStoreInt32ToMemory ].
			[205]	-> [ ^ self genLowcodeStoreInt64ToMemory ].
			[206]	-> [ ^ self genLowcodeStoreInt8ToMemory ].
			[207]	-> [ ^ self genLowcodeStoreLocalFloat32 ].
			[208]	-> [ ^ self genLowcodeStoreLocalFloat64 ].
			[209]	-> [ ^ self genLowcodeStoreLocalInt16 ].
			[210]	-> [ ^ self genLowcodeStoreLocalInt32 ].
			[211]	-> [ ^ self genLowcodeStoreLocalInt64 ].
			[212]	-> [ ^ self genLowcodeStoreLocalInt8 ].
			[213]	-> [ ^ self genLowcodeStoreLocalPointer ].
			[214]	-> [ ^ self genLowcodeStorePointerToMemory ].
			[215]	-> [ ^ self genLowcodeSub32 ].
			[216]	-> [ ^ self genLowcodeSub64 ].
			[217]	-> [ ^ self genLowcodeTruncate32To16 ].
			[218]	-> [ ^ self genLowcodeTruncate32To8 ].
			[219]	-> [ ^ self genLowcodeTruncate64To16 ].
			[220]	-> [ ^ self genLowcodeTruncate64To32 ].
			[221]	-> [ ^ self genLowcodeTruncate64To8 ].
			[222]	-> [ ^ self genLowcodeUdiv32 ].
			[223]	-> [ ^ self genLowcodeUdiv64 ].
			[224]	-> [ ^ self genLowcodeUint32Great ].
			[225]	-> [ ^ self genLowcodeUint32GreatEqual ].
			[226]	-> [ ^ self genLowcodeUint32Less ].
			[227]	-> [ ^ self genLowcodeUint32LessEqual ].
			[228]	-> [ ^ self genLowcodeUint32ToFloat32 ].
			[229]	-> [ ^ self genLowcodeUint32ToFloat64 ].
			[230]	-> [ ^ self genLowcodeUint64Great ].
			[231]	-> [ ^ self genLowcodeUint64GreatEqual ].
			[232]	-> [ ^ self genLowcodeUint64Less ].
			[233]	-> [ ^ self genLowcodeUint64LessEqual ].
			[234]	-> [ ^ self genLowcodeUint64ToFloat32 ].
			[235]	-> [ ^ self genLowcodeUint64ToFloat64 ].
			[236]	-> [ ^ self genLowcodeUmul32 ].
			[237]	-> [ ^ self genLowcodeUmul64 ].
			[238]	-> [ ^ self genLowcodeUnlockRegisters ].
			[239]	-> [ ^ self genLowcodeUnlockVM ].
			[240]	-> [ ^ self genLowcodeUrem32 ].
			[241]	-> [ ^ self genLowcodeUrem64 ].
			[242]	-> [ ^ self genLowcodeXor32 ].
			[243]	-> [ ^ self genLowcodeXor64 ].
			[244]	-> [ ^ self genLowcodeZeroExtend32From16 ].
			[245]	-> [ ^ self genLowcodeZeroExtend32From8 ].
			[246]	-> [ ^ self genLowcodeZeroExtend64From16 ].
		}
		otherwise: [ ^ self genLowcodeUnaryInlinePrimitive5: prim ].
	^ 0

