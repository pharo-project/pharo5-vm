inline primitive generators dispatch generated code
genLowcodeUnaryInlinePrimitive2: prim
	<option: #LowcodeVM>	"Lowcode instruction generator dispatch"
	prim
		caseOf: {
			[60]	-> [ ^ self genLowcodeFloat64ToFloat32 ].
			[61]	-> [ ^ self genLowcodeFloat64ToInt32 ].
			[62]	-> [ ^ self genLowcodeFloat64ToInt64 ].
			[63]	-> [ ^ self genLowcodeFloat64ToUInt32 ].
			[64]	-> [ ^ self genLowcodeFloat64ToUInt64 ].
			[65]	-> [ ^ self genLowcodeFree ].
			[66]	-> [ ^ self genLowcodeInstantiateIndexable32Oop ].
			[67]	-> [ ^ self genLowcodeInstantiateIndexableOop ].
			[68]	-> [ ^ self genLowcodeInstantiateOop ].
			[69]	-> [ ^ self genLowcodeInt32Equal ].
			[70]	-> [ ^ self genLowcodeInt32Great ].
			[71]	-> [ ^ self genLowcodeInt32GreatEqual ].
			[72]	-> [ ^ self genLowcodeInt32Less ].
			[73]	-> [ ^ self genLowcodeInt32LessEqual ].
			[74]	-> [ ^ self genLowcodeInt32NotEqual ].
			[75]	-> [ ^ self genLowcodeInt32ToFloat32 ].
			[76]	-> [ ^ self genLowcodeInt32ToFloat64 ].
			[77]	-> [ ^ self genLowcodeInt32ToPointer ].
			[78]	-> [ ^ self genLowcodeInt64Equal ].
			[79]	-> [ ^ self genLowcodeInt64Great ].
			[80]	-> [ ^ self genLowcodeInt64GreatEqual ].
			[81]	-> [ ^ self genLowcodeInt64Less ].
			[82]	-> [ ^ self genLowcodeInt64LessEqual ].
			[83]	-> [ ^ self genLowcodeInt64NotEqual ].
			[84]	-> [ ^ self genLowcodeInt64ToFloat32 ].
			[85]	-> [ ^ self genLowcodeInt64ToFloat64 ].
			[86]	-> [ ^ self genLowcodeInt64ToPointer ].
			[87]	-> [ ^ self genLowcodeLeftShift32 ].
			[88]	-> [ ^ self genLowcodeLeftShift64 ].
			[89]	-> [ ^ self genLowcodeLoadArgumentAddress ].
			[90]	-> [ ^ self genLowcodeLoadArgumentFloat32 ].
			[91]	-> [ ^ self genLowcodeLoadArgumentFloat64 ].
			[92]	-> [ ^ self genLowcodeLoadArgumentInt16 ].
			[93]	-> [ ^ self genLowcodeLoadArgumentInt32 ].
			[94]	-> [ ^ self genLowcodeLoadArgumentInt64 ].
			[95]	-> [ ^ self genLowcodeLoadArgumentInt8 ].
			[96]	-> [ ^ self genLowcodeLoadArgumentPointer ].
			[97]	-> [ ^ self genLowcodeLoadArgumentUInt16 ].
			[98]	-> [ ^ self genLowcodeLoadArgumentUInt32 ].
			[99]	-> [ ^ self genLowcodeLoadArgumentUInt64 ].
			[100]	-> [ ^ self genLowcodeLoadArgumentUInt8 ].
			[101]	-> [ ^ self genLowcodeLoadFloat32FromMemory ].
			[102]	-> [ ^ self genLowcodeLoadFloat64FromMemory ].
			[103]	-> [ ^ self genLowcodeLoadInt16FromMemory ].
			[104]	-> [ ^ self genLowcodeLoadInt32FromMemory ].
			[105]	-> [ ^ self genLowcodeLoadInt64FromMemory ].
			[106]	-> [ ^ self genLowcodeLoadInt8FromMemory ].
			[107]	-> [ ^ self genLowcodeLoadLocalAddress ].
			[108]	-> [ ^ self genLowcodeLoadLocalFloat32 ].
			[109]	-> [ ^ self genLowcodeLoadLocalFloat64 ].
			[110]	-> [ ^ self genLowcodeLoadLocalInt16 ].
			[111]	-> [ ^ self genLowcodeLoadLocalInt32 ].
			[112]	-> [ ^ self genLowcodeLoadLocalInt64 ].
			[113]	-> [ ^ self genLowcodeLoadLocalInt8 ].
			[114]	-> [ ^ self genLowcodeLoadLocalPointer ].
			[115]	-> [ ^ self genLowcodeLoadLocalUInt16 ].
			[116]	-> [ ^ self genLowcodeLoadLocalUInt32 ].
			[117]	-> [ ^ self genLowcodeLoadLocalUInt64 ].
			[118]	-> [ ^ self genLowcodeLoadLocalUInt8 ].
			[119]	-> [ ^ self genLowcodeLoadObjectAt ].
		}
		otherwise: [ ^ self genLowcodeUnaryInlinePrimitive3: prim ].
	^ 0

