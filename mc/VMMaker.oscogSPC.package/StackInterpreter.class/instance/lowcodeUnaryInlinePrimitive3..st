inline primitive dispatch generated code
lowcodeUnaryInlinePrimitive3: prim
	<option: #LowcodeVM>	"Lowcode instruction interpreter dispatch"
	prim
		caseOf: {
			[120]	-> [ ^ self lowcodePrimitiveLoadObjectField ].
			[121]	-> [ ^ self lowcodePrimitiveLoadPointerFromMemory ].
			[122]	-> [ ^ self lowcodePrimitiveLoadUInt16FromMemory ].
			[123]	-> [ ^ self lowcodePrimitiveLoadUInt32FromMemory ].
			[124]	-> [ ^ self lowcodePrimitiveLoadUInt64FromMemory ].
			[125]	-> [ ^ self lowcodePrimitiveLoadUInt8FromMemory ].
			[126]	-> [ ^ self lowcodePrimitiveLocalFrameSize ].
			[127]	-> [ ^ self lowcodePrimitiveLockRegisters ].
			[128]	-> [ ^ self lowcodePrimitiveLockVM ].
			[129]	-> [ ^ self lowcodePrimitiveMalloc32 ].
			[130]	-> [ ^ self lowcodePrimitiveMalloc64 ].
			[131]	-> [ ^ self lowcodePrimitiveMemcpy32 ].
			[132]	-> [ ^ self lowcodePrimitiveMemcpy64 ].
			[133]	-> [ ^ self lowcodePrimitiveMemcpyFixed ].
			[134]	-> [ ^ self lowcodePrimitiveMoveFloat32ToPhysical ].
			[135]	-> [ ^ self lowcodePrimitiveMoveFloat64ToPhysical ].
			[136]	-> [ ^ self lowcodePrimitiveMoveInt32ToPhysical ].
			[137]	-> [ ^ self lowcodePrimitiveMoveInt64ToPhysical ].
			[138]	-> [ ^ self lowcodePrimitiveMovePointerToPhysical ].
			[139]	-> [ ^ self lowcodePrimitiveMul32 ].
			[140]	-> [ ^ self lowcodePrimitiveMul64 ].
			[141]	-> [ ^ self lowcodePrimitiveNeg32 ].
			[142]	-> [ ^ self lowcodePrimitiveNeg64 ].
			[143]	-> [ ^ self lowcodePrimitiveNot32 ].
			[144]	-> [ ^ self lowcodePrimitiveNot64 ].
			[145]	-> [ ^ self lowcodePrimitiveOr32 ].
			[146]	-> [ ^ self lowcodePrimitiveOr64 ].
			[147]	-> [ ^ self lowcodePrimitivePerformCallFloat32 ].
			[148]	-> [ ^ self lowcodePrimitivePerformCallFloat64 ].
			[149]	-> [ ^ self lowcodePrimitivePerformCallIndirectFloat32 ].
			[150]	-> [ ^ self lowcodePrimitivePerformCallIndirectFloat64 ].
			[151]	-> [ ^ self lowcodePrimitivePerformCallIndirectInt32 ].
			[152]	-> [ ^ self lowcodePrimitivePerformCallIndirectInt64 ].
			[153]	-> [ ^ self lowcodePrimitivePerformCallIndirectPointer ].
			[154]	-> [ ^ self lowcodePrimitivePerformCallIndirectStructure ].
			[155]	-> [ ^ self lowcodePrimitivePerformCallIndirectVoid ].
			[156]	-> [ ^ self lowcodePrimitivePerformCallInt32 ].
			[157]	-> [ ^ self lowcodePrimitivePerformCallInt64 ].
			[158]	-> [ ^ self lowcodePrimitivePerformCallPointer ].
			[159]	-> [ ^ self lowcodePrimitivePerformCallStructure ].
			[160]	-> [ ^ self lowcodePrimitivePerformCallVoid ].
			[161]	-> [ ^ self lowcodePrimitivePlaftormCode ].
			[162]	-> [ ^ self lowcodePrimitivePointerAddConstantOffset ].
			[163]	-> [ ^ self lowcodePrimitivePointerAddOffset32 ].
			[164]	-> [ ^ self lowcodePrimitivePointerAddOffset64 ].
			[165]	-> [ ^ self lowcodePrimitivePointerEqual ].
			[166]	-> [ ^ self lowcodePrimitivePointerNotEqual ].
			[167]	-> [ ^ self lowcodePrimitivePointerToInt32 ].
			[168]	-> [ ^ self lowcodePrimitivePointerToInt64 ].
			[169]	-> [ ^ self lowcodePrimitivePopFloat32 ].
			[170]	-> [ ^ self lowcodePrimitivePopFloat64 ].
			[171]	-> [ ^ self lowcodePrimitivePopInt32 ].
			[172]	-> [ ^ self lowcodePrimitivePopInt64 ].
			[173]	-> [ ^ self lowcodePrimitivePopMultipleNative ].
			[174]	-> [ ^ self lowcodePrimitivePopPointer ].
			[175]	-> [ ^ self lowcodePrimitivePushConstantUInt32 ].
			[176]	-> [ ^ self lowcodePrimitivePushConstantUInt64 ].
			[177]	-> [ ^ self lowcodePrimitivePushNullPointer ].
			[178]	-> [ ^ self lowcodePrimitivePushOne32 ].
			[179]	-> [ ^ self lowcodePrimitivePushOne64 ].
		}
		otherwise: [ ^ self lowcodeUnaryInlinePrimitive4: prim ].
	

