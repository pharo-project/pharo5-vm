compile abstract instructions
nativeStoreToReg: reg
	"FIXME: Duplicated code with popToReg:"
	spilled ifTrue: [cogit loadNativeFramePointerInto: TempReg.].

	type caseOf: {
		[SSSpillNative]	-> [cogit MoveMw: offset negated - 1 r: TempReg R: reg].
		[SSSpillFloat32]	-> [cogit MoveM32: offset negated - 1 r: TempReg Rs: reg.].
		[SSSpillFloat64]	-> [cogit MoveM64: offset negated - 1 r: TempReg Rd: reg.].
		[SSNativeRegister]	-> [reg ~= register
										ifTrue: [cogit MoveR: register R: reg]
										ifFalse: [cogit Label]].
		[SSRegisterSingleFloat]	-> [reg ~= register
										ifTrue: [cogit MoveRs: register Rs: reg]
										ifFalse: [cogit Label]].
		[SSRegisterDoubleFloat]	-> [reg ~= register
										ifTrue: [cogit MoveRd: register Rd: reg]
										ifFalse: [cogit Label]].

		[SSConstantInt32]	-> [cogit MoveCw: constantInt32 R: reg].
		[SSConstantNativePointer]	-> [cogit MoveCw: constantNativePointer R: reg].
		[SSConstantFloat32] -> [ cogit MoveCf32: constantFloat32 Rs: reg. ].
		[SSConstantFloat64] -> [ cogit MoveCf64: constantFloat64 Rd: reg. ].
	}.