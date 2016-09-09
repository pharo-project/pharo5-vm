inline primitive dispatch generated code
lowcodeNullaryInlinePrimitive: prim
	<option: #LowcodeVM>	"Lowcode instruction interpreter dispatch"
	prim
		caseOf: {
			[0]	-> [ ^ self lowcodePrimitiveBoolean32ToOop ].
			[1]	-> [ ^ self lowcodePrimitiveBoolean64ToOop ].
			[2]	-> [ ^ self lowcodePrimitiveFloat32ToOop ].
			[3]	-> [ ^ self lowcodePrimitiveFloat64ToOop ].
			[4]	-> [ ^ self lowcodePrimitiveInt32ToOop ].
			[5]	-> [ ^ self lowcodePrimitiveInt64ToOop ].
			[6]	-> [ ^ self lowcodePrimitivePointerToOop ].
			[7]	-> [ ^ self lowcodePrimitivePointerToOopReinterprer ].
			[8]	-> [ ^ self lowcodePrimitiveSmallInt32ToOop ].
			[9]	-> [ ^ self lowcodePrimitiveUint32ToOop ].
			[10]	-> [ ^ self lowcodePrimitiveUint64ToOop ].
		}
		otherwise: [
			localIP := localIP - 3.
			^self respondToUnknownBytecode
		].
	

