inline primitive support
genLcByteSizeOf: oop to: resultRegister
	<option: #LowcodeVM>
	"TODO: Optimize this one avoiding the trampoline"
	oop ~= Arg0Reg ifTrue: [cogit MoveR: oop R: Arg0Reg ].
	cogit CallRT: ceByteSizeOfTrampoline.

	cogit MoveR: TempReg R: resultRegister.
	cogit ssPushNativeRegister: resultRegister.