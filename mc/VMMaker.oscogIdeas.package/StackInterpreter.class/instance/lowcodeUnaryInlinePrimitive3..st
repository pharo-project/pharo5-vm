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
			[147]	-> [ ^ self lowcodePrimitivePerformCallout ].
			[148]	-> [ ^ self lowcodePrimitivePerformCalloutIndirect ].
			[149]	-> [ ^ self lowcodePrimitivePushCalloutResultFloat32 ].
			[150]	-> [ ^ self lowcodePrimitivePushCalloutResultFloat64 ].
			[151]	-> [ ^ self lowcodePrimitivePushCalloutResultInt32 ].
			[152]	-> [ ^ self lowcodePrimitivePushCalloutResultInt64 ].
			[153]	-> [ ^ self lowcodePrimitivePushCalloutResultPointer ].
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
			[180]	-> [ ^ self lowcodePrimitivePushOneFloat32 ].
			[181]	-> [ ^ self lowcodePrimitivePushOneFloat64 ].
			[182]	-> [ ^ self lowcodePrimitivePushPhysicalFloat32 ].
			[183]	-> [ ^ self lowcodePrimitivePushPhysicalFloat64 ].
			[184]	-> [ ^ self lowcodePrimitivePushPhysicalInt32 ].
			[185]	-> [ ^ self lowcodePrimitivePushPhysicalInt64 ].
			[186]	-> [ ^ self lowcodePrimitivePushPhysicalPointer ].
		}
		otherwise: [ ^ self lowcodeUnaryInlinePrimitive4: prim ].
	

