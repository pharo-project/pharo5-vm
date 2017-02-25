compile abstract instructions
ensureSpilledSP: spRegister scratchRegister: scratchRegister
	spilled ifFalse: [
		type caseOf: {
			[SSNativeRegister]	-> [
					cogit MoveR: register Mw: offset negated - 1 r: spRegister.
					type := SSSpillNative.
				].
			[SSRegisterSingleFloat]	-> [
					cogit MoveRs: register M32: offset negated - 1 r: spRegister.
					type := SSSpillFloat32.
				].
			[SSRegisterDoubleFloat] -> [
					cogit MoveRd: register M64: offset negated - 1 r: spRegister.
					type := SSSpillFloat64.
				].
			[SSConstantFloat32] -> [
				cogit MoveCw: constantFloat32 asIEEE32BitWord R: scratchRegister.
				cogit MoveR: scratchRegister M32: offset negated - 1 r: spRegister.
				type := SSSpillFloat32.
			].
			[SSConstantFloat64] -> [
				BytesPerWord == 4 ifTrue: [
					cogit MoveCw: (constantFloat64 asIEEE64BitWord bitAnd: 16rFFFFFFFF) R: scratchRegister.
					cogit MoveR: scratchRegister M32: offset negated - 1 r: spRegister.
					cogit MoveCw: (constantFloat64 asIEEE64BitWord bitShift: (self cCoerce: -32 to: #'sqLong')) R: scratchRegister.
					cogit MoveR: scratchRegister M32: offset negated - 1 + 4 r: spRegister.
				] ifFalse: [
					cogit MoveCw: constantFloat32 asIEEE64BitWord R: scratchRegister.
					cogit MoveR: scratchRegister Mw: offset negated - 1 r: spRegister.
				].
				type := SSSpillFloat64.
			].
			[SSConstantInt32]	-> [
					cogit MoveCq: constantInt32 R: scratchRegister.
					cogit MoveR: scratchRegister Mw: offset negated - 1 r: spRegister.
					type := SSSpillNative.
				].
			[SSConstantNativePointer]	-> [
					cogit MoveCw: constantNativePointer R: scratchRegister.
					cogit MoveR: scratchRegister Mw: offset negated - 1 r: spRegister.
					type := SSSpillNative.
				].
		}
	].

	spilled := true.

