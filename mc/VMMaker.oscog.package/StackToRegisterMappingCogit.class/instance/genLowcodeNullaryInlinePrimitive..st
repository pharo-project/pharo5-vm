inline primitive generators dispatch generated code
genLowcodeNullaryInlinePrimitive: prim
	<option: #LowcodeVM>	"Lowcode instruction generator dispatch"
	prim
		caseOf: {
			[0]	-> [ ^ self genLowcodeBoolean32ToOop ].
			[1]	-> [ ^ self genLowcodeBoolean64ToOop ].
			[2]	-> [ ^ self genLowcodeFloat32ToOop ].
			[3]	-> [ ^ self genLowcodeFloat64ToOop ].
			[4]	-> [ ^ self genLowcodeInt32ToOop ].
			[5]	-> [ ^ self genLowcodeInt64ToOop ].
			[6]	-> [ ^ self genLowcodePointerToOop ].
			[7]	-> [ ^ self genLowcodePointerToOopReinterprer ].
			[8]	-> [ ^ self genLowcodeSmallInt32ToOop ].
			[9]	-> [ ^ self genLowcodeUint32ToOop ].
			[10]	-> [ ^ self genLowcodeUint64ToOop ].
		}
		otherwise: [ ^ EncounteredUnknownBytecode ].
	^ 0

