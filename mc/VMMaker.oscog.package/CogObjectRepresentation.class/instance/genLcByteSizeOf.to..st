inline primitive support
genLcByteSizeOf: oop to: resultRegister
	<option: #LowcodeVM>
	"TODO: Optimize this one avoiding the trampoline"
	oop ~= ReceiverResultReg ifTrue: [cogit MoveR: oop R: ReceiverResultReg ].
	cogit CallRT: ceByteSizeOfTrampoline.

	cogit MoveR: TempReg R: resultRegister.
	cogit ssPushNativeRegister: resultRegister.