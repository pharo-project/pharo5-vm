compile abstract instructions
ensureIsMarkedAsSpilled
	spilled ifFalse: [
		type caseOf: {
			[SSNativeRegister]	-> [ type := SSSpillNative ].
			[SSRegisterSingleFloat]	-> [ type := SSSpillFloat32 ].
			[SSRegisterDoubleFloat] -> [ type := SSSpillFloat64 ].
			[SSConstantFloat32] -> [ type := SSSpillFloat32. ].
			[SSConstantFloat64] -> [ type := SSSpillFloat64. ].
			[SSConstantInt32]	-> [ type := SSSpillNative. ].
			[SSConstantNativePointer]	-> [ type := SSSpillNative. ].
		}
	].

	spilled := true.
