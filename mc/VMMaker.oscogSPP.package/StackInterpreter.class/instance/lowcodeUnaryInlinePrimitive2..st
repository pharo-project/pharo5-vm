inline primitive dispatch generated code
lowcodeUnaryInlinePrimitive2: prim
	<option: #LowcodeVM>	"Lowcode instruction interpreter dispatch"
	prim
		caseOf: {
			[60]	-> [ ^ self lowcodePrimitiveFloat64ToFloat32 ].
			[61]	-> [ ^ self lowcodePrimitiveFloat64ToInt32 ].
			[62]	-> [ ^ self lowcodePrimitiveFloat64ToInt64 ].
			[63]	-> [ ^ self lowcodePrimitiveFloat64ToUInt32 ].
			[64]	-> [ ^ self lowcodePrimitiveFloat64ToUInt64 ].
			[65]	-> [ ^ self lowcodePrimitiveFree ].
			[66]	-> [ ^ self lowcodePrimitiveInstantiateIndexable32Oop ].
			[67]	-> [ ^ self lowcodePrimitiveInstantiateIndexableOop ].
			[68]	-> [ ^ self lowcodePrimitiveInstantiateOop ].
			[69]	-> [ ^ self lowcodePrimitiveInt32Equal ].
			[70]	-> [ ^ self lowcodePrimitiveInt32Great ].
			[71]	-> [ ^ self lowcodePrimitiveInt32GreatEqual ].
			[72]	-> [ ^ self lowcodePrimitiveInt32Less ].
			[73]	-> [ ^ self lowcodePrimitiveInt32LessEqual ].
			[74]	-> [ ^ self lowcodePrimitiveInt32NotEqual ].
			[75]	-> [ ^ self lowcodePrimitiveInt32ToFloat32 ].
			[76]	-> [ ^ self lowcodePrimitiveInt32ToFloat64 ].
			[77]	-> [ ^ self lowcodePrimitiveInt32ToPointer ].
			[78]	-> [ ^ self lowcodePrimitiveInt64Equal ].
			[79]	-> [ ^ self lowcodePrimitiveInt64Great ].
			[80]	-> [ ^ self lowcodePrimitiveInt64GreatEqual ].
			[81]	-> [ ^ self lowcodePrimitiveInt64Less ].
			[82]	-> [ ^ self lowcodePrimitiveInt64LessEqual ].
			[83]	-> [ ^ self lowcodePrimitiveInt64NotEqual ].
			[84]	-> [ ^ self lowcodePrimitiveInt64ToFloat32 ].
			[85]	-> [ ^ self lowcodePrimitiveInt64ToFloat64 ].
			[86]	-> [ ^ self lowcodePrimitiveInt64ToPointer ].
			[87]	-> [ ^ self lowcodePrimitiveLeftShift32 ].
			[88]	-> [ ^ self lowcodePrimitiveLeftShift64 ].
			[89]	-> [ ^ self lowcodePrimitiveLoadArgumentAddress ].
			[90]	-> [ ^ self lowcodePrimitiveLoadArgumentFloat32 ].
			[91]	-> [ ^ self lowcodePrimitiveLoadArgumentFloat64 ].
			[92]	-> [ ^ self lowcodePrimitiveLoadArgumentInt16 ].
			[93]	-> [ ^ self lowcodePrimitiveLoadArgumentInt32 ].
			[94]	-> [ ^ self lowcodePrimitiveLoadArgumentInt64 ].
			[95]	-> [ ^ self lowcodePrimitiveLoadArgumentInt8 ].
			[96]	-> [ ^ self lowcodePrimitiveLoadArgumentPointer ].
			[97]	-> [ ^ self lowcodePrimitiveLoadArgumentUInt16 ].
			[98]	-> [ ^ self lowcodePrimitiveLoadArgumentUInt32 ].
			[99]	-> [ ^ self lowcodePrimitiveLoadArgumentUInt64 ].
			[100]	-> [ ^ self lowcodePrimitiveLoadArgumentUInt8 ].
			[101]	-> [ ^ self lowcodePrimitiveLoadFloat32FromMemory ].
			[102]	-> [ ^ self lowcodePrimitiveLoadFloat64FromMemory ].
			[103]	-> [ ^ self lowcodePrimitiveLoadInt16FromMemory ].
			[104]	-> [ ^ self lowcodePrimitiveLoadInt32FromMemory ].
			[105]	-> [ ^ self lowcodePrimitiveLoadInt64FromMemory ].
			[106]	-> [ ^ self lowcodePrimitiveLoadInt8FromMemory ].
			[107]	-> [ ^ self lowcodePrimitiveLoadLocalAddress ].
			[108]	-> [ ^ self lowcodePrimitiveLoadLocalFloat32 ].
			[109]	-> [ ^ self lowcodePrimitiveLoadLocalFloat64 ].
			[110]	-> [ ^ self lowcodePrimitiveLoadLocalInt16 ].
			[111]	-> [ ^ self lowcodePrimitiveLoadLocalInt32 ].
			[112]	-> [ ^ self lowcodePrimitiveLoadLocalInt64 ].
			[113]	-> [ ^ self lowcodePrimitiveLoadLocalInt8 ].
			[114]	-> [ ^ self lowcodePrimitiveLoadLocalPointer ].
			[115]	-> [ ^ self lowcodePrimitiveLoadLocalUInt16 ].
			[116]	-> [ ^ self lowcodePrimitiveLoadLocalUInt32 ].
			[117]	-> [ ^ self lowcodePrimitiveLoadLocalUInt64 ].
			[118]	-> [ ^ self lowcodePrimitiveLoadLocalUInt8 ].
			[119]	-> [ ^ self lowcodePrimitiveLoadObjectAt ].
		}
		otherwise: [ ^ self lowcodeUnaryInlinePrimitive3: prim ].
	

