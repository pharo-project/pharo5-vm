compile abstract instructions
nativePopToReg: reg
	spilled ifTrue: [
		cogit loadNativeFramePointerInto: TempReg.

		type caseOf: {
			[SSSpillNative]	-> [cogit MoveMw: offset negated - 1 r: TempReg R: reg].
			[SSSpillFloat32]	-> [cogit MoveM32: offset negated - 1 r: TempReg Rs: reg.].
			[SSSpillFloat64]	-> [cogit MoveM64: offset negated - 1 r: TempReg Rd: reg.].}
	] ifFalse: [
		type caseOf: {
			[SSNativeRegister]	-> [reg ~= register
											ifTrue: [cogit MoveR: register R: reg]].
			[SSRegisterSingleFloat]	-> [reg ~= register
											ifTrue: [cogit MoveRs: register Rs: reg]].
			[SSRegisterDoubleFloat]	-> [reg ~= register
											ifTrue: [cogit MoveRd: register Rd: reg]].

			[SSConstantInt32]	-> [cogit MoveCq: constantInt32 R: reg].
			[SSConstantNativePointer]	-> [cogit MoveCw: constantNativePointer R: reg].
			[SSConstantFloat32] -> [ cogit MoveCf32: constantFloat32 Rs: reg. ].
			[SSConstantFloat64] -> [ cogit MoveCf64: constantFloat64 Rd: reg. ].
		 }
	].
