inline primitive dispatch generated code
lowcodeTrinaryInlinePrimitive: prim
	<option: #LowcodeVM>	"Lowcode instruction interpreter dispatch"
	prim
		caseOf: {
			[0]	-> [ ^ self lowcodePrimitiveOopEqual ].
			[1]	-> [ ^ self lowcodePrimitiveOopNotEqual ].
			[2]	-> [ ^ self lowcodePrimitiveStoreObjectField ].
			[3]	-> [ ^ self lowcodePrimitiveStoreObjectFieldAt ].
		}
		otherwise: [
			localIP := localIP - 3.
			^self respondToUnknownBytecode
		].
	

