inline primitive dispatch generated code
lowcodeBinaryInlinePrimitive: prim
	<option: #LowcodeVM>	"Lowcode instruction interpreter dispatch"
	prim
		caseOf: {
			[0]	-> [ ^ self lowcodePrimitiveByteSizeOf ].
			[1]	-> [ ^ self lowcodePrimitiveFirstFieldPointer ].
			[2]	-> [ ^ self lowcodePrimitiveFirstIndexableFieldPointer ].
			[3]	-> [ ^ self lowcodePrimitiveIsBytes ].
			[4]	-> [ ^ self lowcodePrimitiveIsFloatObject ].
			[5]	-> [ ^ self lowcodePrimitiveIsIndexable ].
			[6]	-> [ ^ self lowcodePrimitiveIsIntegerObject ].
			[7]	-> [ ^ self lowcodePrimitiveIsPointers ].
			[8]	-> [ ^ self lowcodePrimitiveIsWords ].
			[9]	-> [ ^ self lowcodePrimitiveIsWordsOrBytes ].
			[10]	-> [ ^ self lowcodePrimitiveOopSmallIntegerToInt32 ].
			[11]	-> [ ^ self lowcodePrimitiveOopSmallIntegerToInt64 ].
			[12]	-> [ ^ self lowcodePrimitiveOopToBoolean32 ].
			[13]	-> [ ^ self lowcodePrimitiveOopToBoolean64 ].
			[14]	-> [ ^ self lowcodePrimitiveOopToFloat32 ].
			[15]	-> [ ^ self lowcodePrimitiveOopToFloat64 ].
			[16]	-> [ ^ self lowcodePrimitiveOopToInt32 ].
			[17]	-> [ ^ self lowcodePrimitiveOopToInt64 ].
			[18]	-> [ ^ self lowcodePrimitiveOopToPointer ].
			[19]	-> [ ^ self lowcodePrimitiveOopToPointerReinterpret ].
			[20]	-> [ ^ self lowcodePrimitiveOopToUInt32 ].
			[21]	-> [ ^ self lowcodePrimitiveOopToUInt64 ].
			[22]	-> [ ^ self lowcodePrimitivePin ].
			[23]	-> [ ^ self lowcodePrimitiveUnpin ].
		}
		otherwise: [
			localIP := localIP - 3.
			^self respondToUnknownBytecode
		].
	

