inline primitive generators dispatch generated code
genLowcodeUnaryInlinePrimitive3: prim
	<option: #LowcodeVM>	"Lowcode instruction generator dispatch"
	prim
		caseOf: {
			[120]	-> [ ^ self genLowcodeLoadObjectField ].
			[121]	-> [ ^ self genLowcodeLoadPointerFromMemory ].
			[122]	-> [ ^ self genLowcodeLoadUInt16FromMemory ].
			[123]	-> [ ^ self genLowcodeLoadUInt32FromMemory ].
			[124]	-> [ ^ self genLowcodeLoadUInt64FromMemory ].
			[125]	-> [ ^ self genLowcodeLoadUInt8FromMemory ].
			[126]	-> [ ^ self genLowcodeLocalFrameSize ].
			[127]	-> [ ^ self genLowcodeLockRegisters ].
			[128]	-> [ ^ self genLowcodeLockVM ].
			[129]	-> [ ^ self genLowcodeMalloc32 ].
			[130]	-> [ ^ self genLowcodeMalloc64 ].
			[131]	-> [ ^ self genLowcodeMemcpy32 ].
			[132]	-> [ ^ self genLowcodeMemcpy64 ].
			[133]	-> [ ^ self genLowcodeMemcpyFixed ].
			[134]	-> [ ^ self genLowcodeMoveFloat32ToPhysical ].
			[135]	-> [ ^ self genLowcodeMoveFloat64ToPhysical ].
			[136]	-> [ ^ self genLowcodeMoveInt32ToPhysical ].
			[137]	-> [ ^ self genLowcodeMoveInt64ToPhysical ].
			[138]	-> [ ^ self genLowcodeMovePointerToPhysical ].
			[139]	-> [ ^ self genLowcodeMul32 ].
			[140]	-> [ ^ self genLowcodeMul64 ].
			[141]	-> [ ^ self genLowcodeNeg32 ].
			[142]	-> [ ^ self genLowcodeNeg64 ].
			[143]	-> [ ^ self genLowcodeNot32 ].
			[144]	-> [ ^ self genLowcodeNot64 ].
			[145]	-> [ ^ self genLowcodeOr32 ].
			[146]	-> [ ^ self genLowcodeOr64 ].
			[147]	-> [ ^ self genLowcodePerformCallout ].
			[148]	-> [ ^ self genLowcodePerformCalloutIndirect ].
			[149]	-> [ ^ self genLowcodePushCalloutResultFloat32 ].
			[150]	-> [ ^ self genLowcodePushCalloutResultFloat64 ].
			[151]	-> [ ^ self genLowcodePushCalloutResultInt32 ].
			[152]	-> [ ^ self genLowcodePushCalloutResultInt64 ].
			[153]	-> [ ^ self genLowcodePushCalloutResultPointer ].
			[161]	-> [ ^ self genLowcodePlaftormCode ].
			[162]	-> [ ^ self genLowcodePointerAddConstantOffset ].
			[163]	-> [ ^ self genLowcodePointerAddOffset32 ].
			[164]	-> [ ^ self genLowcodePointerAddOffset64 ].
			[165]	-> [ ^ self genLowcodePointerEqual ].
			[166]	-> [ ^ self genLowcodePointerNotEqual ].
			[167]	-> [ ^ self genLowcodePointerToInt32 ].
			[168]	-> [ ^ self genLowcodePointerToInt64 ].
			[169]	-> [ ^ self genLowcodePopFloat32 ].
			[170]	-> [ ^ self genLowcodePopFloat64 ].
			[171]	-> [ ^ self genLowcodePopInt32 ].
			[172]	-> [ ^ self genLowcodePopInt64 ].
			[173]	-> [ ^ self genLowcodePopMultipleNative ].
			[174]	-> [ ^ self genLowcodePopPointer ].
			[175]	-> [ ^ self genLowcodePushConstantUInt32 ].
			[176]	-> [ ^ self genLowcodePushConstantUInt64 ].
			[177]	-> [ ^ self genLowcodePushNullPointer ].
			[178]	-> [ ^ self genLowcodePushOne32 ].
			[179]	-> [ ^ self genLowcodePushOne64 ].
			[180]	-> [ ^ self genLowcodePushOneFloat32 ].
			[181]	-> [ ^ self genLowcodePushOneFloat64 ].
			[182]	-> [ ^ self genLowcodePushPhysicalFloat32 ].
			[183]	-> [ ^ self genLowcodePushPhysicalFloat64 ].
			[184]	-> [ ^ self genLowcodePushPhysicalInt32 ].
			[185]	-> [ ^ self genLowcodePushPhysicalInt64 ].
			[186]	-> [ ^ self genLowcodePushPhysicalPointer ].
		}
		otherwise: [ ^ self genLowcodeUnaryInlinePrimitive4: prim ].
	^ 0

