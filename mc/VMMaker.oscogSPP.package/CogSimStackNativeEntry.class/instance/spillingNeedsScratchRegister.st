compile abstract instructions
spillingNeedsScratchRegister
	spilled ifFalse: [
		type caseOf: {
			[SSConstantInt32]	-> [ ^ true ].
			[SSConstantInt64]	-> [ ^ true ].
			[SSConstantFloat32]	-> [ ^ true ].
			[SSConstantFloat64]	-> [ ^ true ].
			[SSConstantNativePointer]	-> [ ^ true ].
		}
		otherwise: [^ false]
	].

	^ false.
