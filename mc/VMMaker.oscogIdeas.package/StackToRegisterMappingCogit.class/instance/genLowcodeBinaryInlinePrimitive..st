inline primitive generators dispatch generated code
genLowcodeBinaryInlinePrimitive: prim
	<option: #LowcodeVM>	"Lowcode instruction generator dispatch"
	prim
		caseOf: {
			[0]	-> [ ^ self genLowcodeByteSizeOf ].
			[1]	-> [ ^ self genLowcodeFirstFieldPointer ].
			[2]	-> [ ^ self genLowcodeFirstIndexableFieldPointer ].
			[3]	-> [ ^ self genLowcodeIsBytes ].
			[4]	-> [ ^ self genLowcodeIsFloatObject ].
			[5]	-> [ ^ self genLowcodeIsIndexable ].
			[6]	-> [ ^ self genLowcodeIsIntegerObject ].
			[7]	-> [ ^ self genLowcodeIsPointers ].
			[8]	-> [ ^ self genLowcodeIsWords ].
			[9]	-> [ ^ self genLowcodeIsWordsOrBytes ].
			[10]	-> [ ^ self genLowcodeOopSmallIntegerToInt32 ].
			[11]	-> [ ^ self genLowcodeOopSmallIntegerToInt64 ].
			[12]	-> [ ^ self genLowcodeOopToBoolean32 ].
			[13]	-> [ ^ self genLowcodeOopToBoolean64 ].
			[14]	-> [ ^ self genLowcodeOopToFloat32 ].
			[15]	-> [ ^ self genLowcodeOopToFloat64 ].
			[16]	-> [ ^ self genLowcodeOopToInt32 ].
			[17]	-> [ ^ self genLowcodeOopToInt64 ].
			[18]	-> [ ^ self genLowcodeOopToPointer ].
			[19]	-> [ ^ self genLowcodeOopToPointerReinterpret ].
			[20]	-> [ ^ self genLowcodeOopToUInt32 ].
			[21]	-> [ ^ self genLowcodeOopToUInt64 ].
			[22]	-> [ ^ self genLowcodePin ].
			[23]	-> [ ^ self genLowcodeUnpin ].
		}
		otherwise: [ ^ EncounteredUnknownBytecode ].
	^ 0

