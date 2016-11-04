inline primitive generators dispatch generated code
genLowcodeTrinaryInlinePrimitive: prim
	<option: #LowcodeVM>	"Lowcode instruction generator dispatch"
	prim
		caseOf: {
			[0]	-> [ ^ self genLowcodeOopEqual ].
			[1]	-> [ ^ self genLowcodeOopNotEqual ].
			[2]	-> [ ^ self genLowcodeStoreObjectField ].
			[3]	-> [ ^ self genLowcodeStoreObjectFieldAt ].
		}
		otherwise: [ ^ EncounteredUnknownBytecode ].
	^ 0

